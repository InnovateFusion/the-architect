from abc import ABC, abstractmethod
from typing import List
from app.domain.repositories import ContextManagerRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.auth import Auth


class BaseWriteOnlyRepository(ContextManagerRepository):
    @abstractmethod
    async def get_auth(self, auth: Auth) -> Either[Failure, Auth]:
        ...

class BaseRepository(BaseWriteOnlyRepository, ABC):
    ...
