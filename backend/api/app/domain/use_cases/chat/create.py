from core.use_cases.use_case import UseCase
from app.domain.repositories.chat import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.chat import Chat, ChatEntity
from app.domain.entities.message import MessageEntity, Message

class Params(Equatable):
    def __init__(self, message: MessageEntity) -> None:
        self.message = message


class CreateChat(UseCase[Message]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Message]:
        return await self.repository.create_chat(params.message)