from core.use_cases.use_case import UseCase
from app.domain.repositories.chat import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.chat import ChatEntity

class Params(Equatable):
    def __init__(self, user_id: str) -> None:
        self.user_id = user_id

class ViewChats(UseCase[ChatEntity]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, ChatEntity]:
        return await self.repository.view_chats(params.user_id)
