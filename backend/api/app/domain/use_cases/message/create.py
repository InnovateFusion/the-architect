from core.use_cases.use_case import UseCase
from app.domain.repositories.message import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.message import Message, MessageEntity

class Params(Equatable):
    def __init__(self, message: Message, chat_id: str) -> None:
        self.chat_id = chat_id
        self.message = message


class CreateMessage(UseCase[MessageEntity]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, MessageEntity]:
        return await self.repository.create_message(params.message, params.chat_id)