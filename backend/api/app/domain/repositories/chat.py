from abc import ABC, abstractmethod
from typing import List
from api.app.domain.repositories import ContextManagerRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.chat import Chat


class BaseWriteOnlyRepository(ContextManagerRepository):
    @abstractmethod
    async def create_chat(self, chat: Chat) -> Either[Failure, Chat]:
        ...

    @abstractmethod
    async def update_chat(self, chat: Chat) -> Either[Failure, Chat]:
        ...

    @abstractmethod
    async def delete_chat(self, chat_id: str) -> Either[Failure, Chat]:
        ...

class BaseReadOnlyRepository(ABC):
    @abstractmethod
    async def view_chats(self) -> Either[Failure, List[Chat]]:
        ...

    @abstractmethod
    async def view_chat(self, chat_id: str) -> Either[Failure, Chat]:
        ...

class BaseRepository(BaseReadOnlyRepository, BaseWriteOnlyRepository, ABC):
    ...
