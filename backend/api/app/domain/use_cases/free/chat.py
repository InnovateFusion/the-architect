from app.domain.entities.free import Free, FreeEntity
from app.domain.repositories.free import BaseRepository
from core.common.either import Either
from core.common.equatable import Equatable
from core.errors.failure import Failure
from core.use_cases.use_case import UseCase


class Params(Equatable):
    def __init__(self, free: Free) -> None:
        self.free = free

class FreeChat(UseCase[FreeEntity]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, FreeEntity]:
        return await self.repository.free_chat(params.free)