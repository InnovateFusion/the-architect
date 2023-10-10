from typing import Iterable
from core.use_cases.use_case import UseCase, NoParams
from app.domain.repositories.message import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.message import Message

class ViewMessages(UseCase[Iterable[Message]]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: NoParams) -> Either[Failure, Iterable[Message]]:
        return await self.repository.view_messages()