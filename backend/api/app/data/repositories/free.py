from app.data.datasources.local.free import FreeLocalDataSource
from app.domain.entities.free import Free, FreeEntity
from app.domain.repositories.free import BaseRepository
from core.common.either import Either
from core.errors.exceptions import CacheException
from core.errors.failure import CacheFailure, Failure


class FreeRepositoryImpl(BaseRepository):
        
    def __init__(self, free_local_datasource: FreeLocalDataSource):
        self.free_local_datasource = free_local_datasource
        
    async def free_chat(self, free: Free) -> Either[Failure, FreeEntity]:
        try:
            return Either.right(await self.free_local_datasource.free_chat(free))
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
        