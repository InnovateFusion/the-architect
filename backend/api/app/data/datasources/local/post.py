from abc import ABC, abstractmethod
from typing import List
from uuid import uuid4

from app.data.models.post import CloneModel, LikeModel, PostModel
from app.data.models.user import UserModel
from app.domain.entities.post import Post, PostEntity
from core.errors.exceptions import CacheException
from sqlalchemy import desc, func, or_
from sqlalchemy.orm import Session


class PostLocalDataSource(ABC):

    @abstractmethod
    async def create_post(self, post: Post) -> PostEntity:
        pass

    @abstractmethod
    async def all_posts(self,  tags: List[str], search_word: str, skip: int, limit: int, user_id: str) -> List[PostEntity]:
        pass

    @abstractmethod
    async def update_post(self, post: Post, post_id: str) -> PostEntity:
        pass

    @abstractmethod
    async def delete_post(self, post_id: str) -> PostEntity:
        pass

    @abstractmethod
    async def view_posts(self, user_id: str) -> List[PostEntity]:
        pass

    @abstractmethod
    async def view_post(self, post_id: str) -> PostEntity:
        pass

    @abstractmethod
    async def like_post(self, post_id: str, user_id: str) -> PostEntity:
        pass

    @abstractmethod
    async def unlike_post(self, post_id: str, user_id: str) -> PostEntity:
        pass

    @abstractmethod
    async def clone_post(self, post_id: str, user_id: str) -> PostEntity:
        pass

    @abstractmethod
    async def unclone_post(self, post_id: str, user_id: str) -> PostEntity:
        pass


class PostLocalDataSourceImpl(PostLocalDataSource):
    def __init__(self, db: Session):
        self.db = db

    async def create_post(self, post: Post) -> PostEntity:
        existing_user = self.db.query(UserModel).filter(
            UserModel.id == post.userId).first()
        if not existing_user:
            raise CacheException("User does not exist")

        _post = PostModel(
            id=str(uuid4()),
            title=post.title,
            content=post.content,
            image=post.image,
            user_id=post.userId,
            tags=post.tags
        )

        self.db.add(_post)
        self.db.commit()

        return PostEntity(
            id=_post.id,
            userId=post.userId,
            image=post.image,
            firstName=existing_user.first_name,
            lastName=existing_user.last_name,
            title=post.title,
            content=post.content,
            userImage=existing_user.image,
            date=_post.date,
            isLiked=False,
            isCloned=False,
            like=0,
            clone=0,
            tags=post.tags
        )

    async def update_post(self, post: Post, post_id: str) -> PostEntity:
        _post = self.db.query(PostModel).filter(
            PostModel.id == post_id).first()
        if not _post:
            raise CacheException("Post not found")

        user = self.db.query(UserModel).filter(
            UserModel.id == post.userId).first()

        _post.title = post.title
        _post.content = post.content
        _post.image = post.image
        _post.tags = post.tags

        self.db.commit()

        return PostEntity(
            id=_post.id,
            userId=_post.user_id,
            image=_post.image,
            title=_post.title,
            content=_post.content,
            date=_post.date,
            userImage=user.image,
            firstName=user.first_name,
            lastName=user.last_name,
            isLiked=_post.is_liked(self.db, post.userId),
            isCloned=_post.is_cloned(self.db, post.userId),
            like=_post.get_likes_count(self.db),
            clone=_post.get_clones_count(self.db),
            tags=_post.tags
        )

    async def delete_post(self, post_id: str) -> PostEntity:
        _post = self.db.query(PostModel).filter(
            PostModel.id == post_id).first()
        if not _post:
            raise CacheException("Post not found")

        self.db.delete(_post)
        self.db.commit()

        user = self.db.query(UserModel).filter(
            UserModel.id == _post.user_id).first()

        return PostEntity(
            id=_post.id,
            userId=_post.user_id,
            image=_post.image,
            title=_post.title,
            content=_post.content,
            date=_post.date,
            userImage=user.image,
            firstName=user.first_name,
            lastName=user.last_name,
            isLiked=_post.is_liked(self.db, _post.user_id),
            isCloned=_post.is_cloned(self.db, _post.user_id),
            like=_post.get_likes_count(self.db),
            clone=_post.get_clones_count(self.db),
            tags=_post.tags
        )

    async def view_posts(self, user_id) -> List[PostEntity]:
        posts = self.db.query(PostModel).filter(
            PostModel.user_id == user_id).all()

        post_entities = []
        for post in posts:
            user = self.db.query(UserModel).filter(
                UserModel.id == post.user_id).first()
            post_entities.append(PostEntity(
                id=post.id,
                userId=post.user_id,
                image=post.image,
                firstName=user.first_name,
                lastName=user.last_name,
                title=post.title,
                content=post.content,
                userImage=user.image,
                date=post.date,
                isLiked=post.is_liked(self.db, post.user_id),
                isCloned=post.is_cloned(self.db, post.user_id),
                like=post.get_likes_count(self.db),
                clone=post.get_clones_count(self.db),
                tags=post.tags
            ))
        return post_entities

    async def view_post(self, post_id: str) -> PostEntity:
        _post = self.db.query(PostModel).filter(
            PostModel.id == post_id).first()
        if not _post:
            raise CacheException("Post not found")

        user = self.db.query(UserModel).filter(
            UserModel.id == _post.user_id).first()
        return PostEntity(
            id=_post.id,
            userId=_post.user_id,
            image=_post.image,
            firstName=user.first_name,
            lastName=user.last_name,
            title=_post.title,
            content=_post.content,
            userImage=user.image,
            date=_post.date,
            isLiked=_post.is_liked(self.db, _post.user_id),
            isCloned=_post.is_cloned(self.db, _post.user_id),
            like=_post.get_likes_count(self.db),
            clone=_post.get_clones_count(self.db),
            tags=_post.tags
        )

    async def like_post(self, post_id: str, user_id: str) -> PostEntity:
        post = self.db.query(PostModel).filter(PostModel.id == post_id).first()
        if not post:
            raise CacheException("Post not found")

        isLiked = post.is_liked(self.db, user_id)
        if isLiked:
            raise CacheException("Post already liked")

        like = LikeModel(id=str(uuid4()), user_id=user_id, post_id=post_id)
        self.db.add(like)
        self.db.commit()
        return self._get_post_entity(post, user_id)

    async def unlike_post(self, post_id: str, user_id: str) -> PostEntity:
        like = self.db.query(LikeModel).filter(
            LikeModel.post_id == post_id, LikeModel.user_id == user_id).first()
        if not like:
            raise CacheException("Like not found")

        self.db.delete(like)
        self.db.commit()

        post = self.db.query(PostModel).filter(PostModel.id == post_id).first()
        return self._get_post_entity(post, user_id)

    async def clone_post(self, post_id: str, user_id: str) -> PostEntity:
        post = self.db.query(PostModel).filter(PostModel.id == post_id).first()
        if not post:
            raise CacheException("Post not found")

        isCloned = post.is_cloned(self.db, user_id)
        if isCloned:
            raise CacheException("Post already cloned")

        clone = CloneModel(id=str(uuid4()), user_id=user_id, post_id=post_id)
        self.db.add(clone)
        self.db.commit()

        return self._get_post_entity(post, user_id)

    async def unclone_post(self, post_id: str, user_id: str) -> PostEntity:
        clone = self.db.query(CloneModel).filter(
            CloneModel.post_id == post_id, CloneModel.user_id == user_id).first()
        if not clone:
            raise CacheException("Clone not found")

        self.db.delete(clone)
        self.db.commit()

        post = self.db.query(PostModel).filter(PostModel.id == post_id).first()
        return self._get_post_entity(post, user_id)

    def _get_post_entity(self, post, user_id):
        user = self.db.query(UserModel).filter(
            UserModel.id == post.user_id).first()
        return PostEntity(
            id=post.id,
            userId=post.user_id,
            image=post.image,
            firstName=user.first_name,
            lastName=user.last_name,
            title=post.title,
            content=post.content,
            userImage=user.image,
            date=post.date,
            isLiked=post.is_liked(self.db, user_id),
            isCloned=post.is_cloned(self.db, user_id),
            like=post.get_likes_count(self.db),
            clone=post.get_clones_count(self.db),
            tags=post.tags
        )

    async def all_posts(self, tags: List[str], search_word: str, skip: int, limit: int, user_id: str) -> List[PostEntity]:
        query = self.db.query(PostModel)
        if search_word:
            query = query.filter(
                or_(
                    PostModel.title.ilike(f"%{search_word}%"),
                    UserModel.first_name.ilike(f"%{search_word}%")
                )
            )
        query = query.order_by(desc(PostModel.date))

        posts = posts = query.offset(skip).limit(limit).all()

        post_entities = []
        for post in posts:
            number_of_tags = len(tags)
            for tag in tags:
                if tag in post.tags:
                    number_of_tags -= 1
            if number_of_tags == len(tags) and tags:
                continue
            user = self.db.query(UserModel).filter(
                UserModel.id == post.user_id).first()
            post_entities.append(PostEntity(
                id=post.id,
                userId=user.id,
                image=post.image,
                firstName=user.first_name,
                lastName=user.last_name,
                title=post.title,
                userImage=user.image,
                content=post.content,
                date=post.date,
                isLiked=post.is_liked(self.db, user_id),
                isCloned=post.is_cloned(self.db, user_id),
                like=post.get_likes_count(self.db),
                clone=post.get_clones_count(self.db),
                tags=post.tags
            ))
        return post_entities
