from core.use_cases.use_case import UseCase
from app.domain.repositories.chat import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.chat import ChatEntity

class Params(Equatable):
    def __init__(self, chat_id: str) -> None:
        self.chat_id = chat_id

class ViewChat(UseCase[ChatEntity]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, ChatEntity]:
        return await self.repository.view_chat(params.chat_id)