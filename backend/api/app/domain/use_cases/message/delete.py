from core.use_cases.use_case import UseCase
from app.domain.repositories.message import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.message import Message

class Params(Equatable):
    def __init__(self, message_id: str) -> None:
        self.message_id = message_id

class DeleteMessage(UseCase[Message]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Message]:
        return await self.repository.delete_message(params.message_id)