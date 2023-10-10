from api.core.use_cases.use_case import UseCase
from api.app.domain.repositories.message import BaseRepository
from api.core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.message import Message, MessageEntity

class Params(Equatable):
    def __init__(self, message: MessageEntity) -> None:
        self.message = message


class CreateMessage(UseCase[Message]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Message]:
        return await self.repository.create_message(params.message)