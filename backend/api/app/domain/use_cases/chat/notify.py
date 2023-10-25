from core.use_cases.use_case import UseCase
from app.domain.repositories.chat import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.chat import ChatEntity, Notify

class Params(Equatable):
    def __init__(self, chat_id: str, notify_id: str, notify: Notify) -> None:
        self.notify_id = notify_id
        self.chat_id = chat_id
        self.notify = notify


class CreateChat(UseCase[ChatEntity]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, ChatEntity]:
        return await self.repository.notify(params.chat_id, params.notify_id, params.notify)