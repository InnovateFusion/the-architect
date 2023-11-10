from abc import ABC, abstractmethod

from app.domain.entities.free import FreeEntity, Free
from app.domain.repositories import ContextManagerRepository
from core.common.either import Either
from core.errors.failure import Failure


class BaseWriteOnlyRepository(ContextManagerRepository):
    @abstractmethod
    async def free_chat(self, free: Free) -> Either[Failure, FreeEntity]:
        ...

class BaseRepository(BaseWriteOnlyRepository, ABC):
    ...
