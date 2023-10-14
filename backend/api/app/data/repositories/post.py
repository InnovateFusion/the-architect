from typing import Iterable
from core.common.either import Either
from core.errors.failure import Failure, CacheFailure
from core.errors.exceptions import CacheException
from app.domain.entities.post import Post, PostEntity
from app.domain.repositories.post import BaseRepository
from app.data.datasources.local.post import PostLocalDataSource

class PostRepositoryImpl(BaseRepository):
        
    def __init__(self, post_local_datasource: PostLocalDataSource):
        self.post_local_datasource = post_local_datasource
    
    async def create_post(self, post: Post) -> Either[Failure, PostEntity]:
        try:
            post_entity = await self.post_local_datasource.create_post(post)
            return Either.right(post_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def update_post(self, post: Post) -> Either[Failure, PostEntity]:
        try:
            post_entity = await self.post_local_datasource.update_post(post)
            return Either.right(post_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def delete_post(self, post_id: str) -> Either[Failure, PostEntity]:
        try:
            post_entity = await self.post_local_datasource.delete_post(post_id)
            return Either.right(post_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def view_posts(self, user_id: str) -> Either[Failure, list]:
        try:
            posts = await self.post_local_datasource.view_posts(user_id)
            return Either.right(posts)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def view_post(self, post_id: str) -> Either[Failure, PostEntity]:
        try:
            post_entity = await self.post_local_datasource.view_post(post_id)
            return Either.right(post_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def like_post(self, post_id: str, user_id: str) -> Either[Failure, PostEntity]:
        try:
            post_entity =  await self.post_local_datasource.like_post(post_id, user_id)
            return Either.right(post_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def unlike_post(self, post_id: str, user_id: str) -> Either[Failure, PostEntity]:
        try:
            post_entity = await self.post_local_datasource.unlike_post(post_id, user_id)
            return Either.right(post_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def clone_post(self, post_id: str, user_id: str) -> Either[Failure, PostEntity]:
        try:
            post_entity = await self.post_local_datasource.clone_post(post_id, user_id)
            return Either.right(post_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def unclone_post(self, post_id: str, user_id: str) -> Either[Failure, PostEntity]:
        try:
            post_entity = await self.post_local_datasource.unclone_post(post_id, user_id)
            return Either.right(post_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
        
    async def all_posts(self, tags: list, search_word: str) -> Either[Failure, Iterable[PostEntity]]:
        try:
            posts = await self.post_local_datasource.all_posts(tags, search_word)
            return Either.right(posts)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))