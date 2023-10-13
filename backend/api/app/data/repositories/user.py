from core.common.either import Either
from core.errors.failure import Failure, CacheFailure
from core.errors.exceptions import CacheException
from app.domain.entities.user import User, UserEntity
from app.domain.repositories.user import BaseRepository
from app.data.datasources.local.user import UserLocalDataSource

class UserRepositoryImpl(BaseRepository):
        
    def __init__(self, user_local_datasource: UserLocalDataSource):
        self.user_local_datasource = user_local_datasource
    
    async def create_user(self, user: User) -> Either[Failure, UserEntity]:
        try:
            user_entity = await self.user_local_datasource.create_user(user)
            return Either.right(user_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def update_user(self, user: User) -> Either[Failure, UserEntity]:
        try:
            user_entity = await self.user_local_datasource.update_user(user)
            return Either.right(user_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def delete_user(self, user_id: str) -> Either[Failure, UserEntity]:
        try:
            user_entity = await self.user_local_datasource.delete_user(user_id)
            return Either.right(user_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def view_users(self) -> Either[Failure, list]:
        try:
            users = await self.user_local_datasource.view_users()
            return Either.right(users)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def view_user(self, user_id: str) -> Either[Failure, UserEntity]:
        try:
            user_entity = await self.user_local_datasource.view_user(user_id)
            return Either.right(user_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
        
    async def followers(self, user_id: str) -> Either[Failure, list]:
        try:
            _followers = await self.user_local_datasource.followers(user_id)
            return Either.right(_followers)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
        
    async def following(self, user_id: str) -> Either[Failure, list]:
        try:
            _following = await self.user_local_datasource.following(user_id)
            return Either.right(_following)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def follow(self, user_id: str, follower_id: str) -> Either[Failure, UserEntity]:
        try:
            user_entity = await self.user_local_datasource.follow(user_id, follower_id)
            return Either.right(user_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def unfollow(self, user_id: str, follower_id: str) -> Either[Failure, UserEntity]:
        try:
            user_entity = await self.user_local_datasource.unfollow(user_id, follower_id)
            return Either.right(user_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))