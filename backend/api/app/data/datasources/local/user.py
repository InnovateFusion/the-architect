from abc import ABC, abstractmethod
from typing import List
from uuid import uuid4

import requests
from cloudinary.uploader import upload
from sqlalchemy.orm import Session

from app.data.datasources.remote.ai import AiGeneration
from app.data.models.user import UserModel
from app.domain.entities.user import UpdatUserRequest, User, UserEntity
from core.common.password import get_password_hash
from core.errors.exceptions import CacheException


class UserLocalDataSource(ABC):

    @abstractmethod
    async def create_user(self, user: User) -> UserEntity:
        ...

    @abstractmethod
    async def update_user(self, user: UpdatUserRequest, user_id: str) -> UserEntity:
        ...

    @abstractmethod
    async def delete_user(self, user_id: str) -> UserEntity:
        ...

    @abstractmethod
    async def view_users(self) -> List[UserEntity]:
        ...

    @abstractmethod
    async def view_user(self, user_id: str) -> UserEntity:
        ...

    @abstractmethod
    async def followers(self, user_id: str) -> List[UserEntity]:
        ...

    @abstractmethod
    async def following(self, user_id: str) -> List[UserEntity]:
        ...

    @abstractmethod
    async def follow(self, user_id: str, follower_id: str) -> UserEntity:
        ...

    @abstractmethod
    async def unfollow(self, user_id: str, follower_id: str) -> UserEntity:
        ...


class UserLocalDataSourceImpl(UserLocalDataSource):

    def __init__(self, db: Session):
        self.db = db
        self.ai_generation = AiGeneration(request=requests, upload=upload)

    async def create_user(self, user: User) -> UserEntity:
        _user = self.db.query(UserModel).filter(
            UserModel.email == user.email).first()
        if _user is not None:
            raise CacheException("User already exists")
        if len(user.password) < 8:
            raise CacheException("Password length atleast 8 characters")

        _user = UserModel(
            id=str(uuid4()),
            first_name=user.firstName,
            last_name=user.lastName,
            bio=user.bio,
            image=user.image,
            email=user.email,
            password=get_password_hash(user.password),
            country=user.country
        )

        self.db.add(_user)
        self.db.commit()
        return UserEntity(
            id=_user.id,
            firstName=_user.first_name,
            lastName=_user.last_name,
            bio=_user.bio,
            email=_user.email,
            image=_user.image,
            password=_user.password,
            country=_user.country,
            followers=_user.get_followers_count(self.db),
            following=_user.get_following_count(self.db)
        )

    async def update_user(self, user: UpdatUserRequest, user_id: str) -> UserEntity:

        _user = self.db.query(UserModel).filter(
            UserModel.id == user_id).first()
        if _user is None:
            raise CacheException("User not found")

        if user.firstName is not None and user.firstName != '':
            _user.first_name = user.firstName
        if user.lastName is not None and user.lastName != '':
            _user.last_name = user.lastName
        if user.bio is not None and user.bio != '':
            _user.bio = user.bio
        if user.country is not None and user.country != '':
            _user.country = user.country

        if user.image is not None and user.image != '':
            _user.image = await self.ai_generation.generate_image(user.image)

        self.db.commit()
        return UserEntity(
            id=_user.id,
            firstName=_user.first_name,
            lastName=_user.last_name,
            bio=_user.bio,
            image=_user.image,
            email=_user.email,
            password=_user.password,
            country=_user.country,
            followers=_user.get_followers_count(self.db),
            following=_user.get_following_count(self.db)
        )

    async def delete_user(self, user_id: str) -> UserEntity:
        user = self.db.query(UserModel).filter(UserModel.id == user_id).first()
        if user is None:
            raise CacheException("User not found")
        self.db.delete(user)
        self.db.commit()
        return UserEntity(
            id=user.id,
            firstName=user.first_name,
            lastName=user.last_name,
            bio=user.bio,
            image=user.image,
            email=user.email,
            password=user.password,
            country=user.country,
            followers=user.get_followers_count(self.db),
            following=user.get_following_count(self.db)
        )

    async def view_users(self) -> List[UserEntity]:
        users = self.db.query(UserModel).all()
        return [
            UserEntity(
                id=user.id,
                firstName=user.first_name,
                lastName=user.last_name,
                bio=user.bio,
                email=user.email,
                image=user.image,
                password=user.password,
                country=user.country,
                followers=user.get_followers_count(self.db),
                following=user.get_following_count(self.db)
            ) for user in users
        ]

    async def view_user(self, user_id: str) -> UserEntity:
        user = self.db.query(UserModel).filter(UserModel.id == user_id).first()
        if user is None:
            raise CacheException("User not found")
        return UserEntity(
            id=user.id,
            firstName=user.first_name,
            lastName=user.last_name,
            bio=user.bio,
            email=user.email,
            image=user.image,
            password=user.password,
            country=user.country,
            followers=user.get_followers_count(self.db),
            following=user.get_following_count(self.db)
        )

    async def followers(self, user_id: str) -> List[UserEntity]:
        user = self.db.query(UserModel).filter(UserModel.id == user_id).first()
        if user is None:
            raise CacheException("User not found")
        return [
            UserEntity(
                id=follower.id,
                firstName=follower.first_name,
                lastName=follower.last_name,
                bio=follower.bio,
                email=follower.email,
                image=follower.image,
                password=follower.password,
                country=follower.country,
                followers=follower.get_followers_count(self.db),
                following=follower.get_following_count(self.db)
            ) for follower in user.followers
        ]

    async def following(self, user_id: str) -> List[UserEntity]:
        user = self.db.query(UserModel).filter(UserModel.id == user_id).first()
        if user is None:
            raise CacheException("User not found")
        return [
            UserEntity(
                id=following.id,
                firstName=following.first_name,
                lastName=following.last_name,
                bio=following.bio,
                email=following.email,
                image=following.image,
                password=following.password,
                country=following.country,
                followers=following.get_followers_count(self.db),
                following=following.get_following_count(self.db)
            ) for following in user.following
        ]

    async def follow(self, user_id: str, follower_id: str) -> UserEntity:
        user = self.db.query(UserModel).filter(UserModel.id == user_id).first()
        follower = self.db.query(UserModel).filter(
            UserModel.id == follower_id).first()
        if user is None or follower is None:
            raise CacheException("User not found")
        follower.followers.append(user)
        self.db.commit()
        return UserEntity(
            id=user.id,
            firstName=user.first_name,
            lastName=user.last_name,
            bio=user.bio,
            email=user.email,
            image=user.image,
            password=user.password,
            country=user.country,
            followers=user.get_followers_count(self.db),
            following=user.get_following_count(self.db)
        )

    async def unfollow(self, user_id: str, follower_id: str) -> UserEntity:
        user = self.db.query(UserModel).filter(UserModel.id == user_id).first()
        follower = self.db.query(UserModel).filter(
            UserModel.id == follower_id).first()
        if user is None or follower is None:
            raise CacheException("User not found")
        if user not in follower.followers:
            raise CacheException("User not found")

        follower.followers.remove(user)
        self.db.commit()
        return UserEntity(
            id=user.id,
            firstName=user.first_name,
            lastName=user.last_name,
            bio=user.bio,
            email=user.email,
            image=user.image,
            password=user.password,
            country=user.country,
            followers=user.get_followers_count(self.db),
            following=user.get_following_count(self.db)
        )
