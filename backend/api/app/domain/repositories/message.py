from abc import ABC, abstractmethod
from typing import List
from api.app.domain.repositories import ContextManagerRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.message import Message


class BaseWriteOnlyRepository(ContextManagerRepository):
    @abstractmethod
    async def create_message(self, message: Message) -> Either[Failure, Message]:
        ...

    @abstractmethod
    async def update_message(self, message_id: str, message: Message) -> Either[Failure, Message]:
        ...

    @abstractmethod
    async def delete_message(self, message_id: str) -> Either[Failure, Message]:
        ...

class BaseReadOnlyRepository(ABC):
    @abstractmethod
    async def view_messages(self) -> Either[Failure, List[Message]]:
        ...

    @abstractmethod
    async def view_message(self, message_id: str) -> Either[Failure, Message]:
        ...

class BaseRepository(BaseReadOnlyRepository, BaseWriteOnlyRepository, ABC):
    ...
