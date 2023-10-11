from abc import ABC, abstractmethod
from typing import Iterable
from api.app.domain.repositories import ContextManagerRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.user import UserEntity


class BaseWriteOnlyRepository(ContextManagerRepository):
    @abstractmethod
    async def create_user(self, user: UserEntity) -> Either[Failure, UserEntity]:
        ...

    @abstractmethod
    async def update_user(self, user: UserEntity) -> Either[Failure, UserEntity]:
        ...

    @abstractmethod
    async def delete_user(self, user_id: str) -> Either[Failure, UserEntity]:
        ...

class BaseReadOnlyRepository(ABC):
    @abstractmethod
    async def view_users(self) -> Either[Failure, Iterable[UserEntity]]:
        ...

    @abstractmethod
    async def view_user(self, user_id: str) -> Either[Failure, UserEntity]:
        ...

class BaseRepository(BaseReadOnlyRepository, BaseWriteOnlyRepository, ABC):
    ...