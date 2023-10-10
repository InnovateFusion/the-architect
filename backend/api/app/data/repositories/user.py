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
