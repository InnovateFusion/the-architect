from core.common.either import Either
from core.errors.failure import Failure, CacheFailure
from core.errors.exceptions import CacheException
from app.domain.entities.auth import Auth, AuthEntity
from app.domain.repositories.auth import BaseRepository
from app.data.datasources.local.auth import AuthLocalDataSource

class AuthRepositoryImpl(BaseRepository):
        
    def __init__(self, auth_local_datasource: AuthLocalDataSource):
        self.auth_local_datasource = auth_local_datasource
    
    async def get_auth(self, auth: Auth) -> Either[Failure, AuthEntity]:
        try:
            auth_entity = await self.auth_local_datasource.get_token(auth)
            return Either.right(auth_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

