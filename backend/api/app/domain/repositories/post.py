from abc import ABC, abstractmethod
from typing import Iterable
from api.app.domain.entities.post import Post
from api.app.domain.repositories import ContextManagerRepository
from core.common.either import Either
from core.errors.failure import Failure

class BaseWriteOnlyRepository(ContextManagerRepository):
    @abstractmethod
    async def create_post(self, post: Post) -> Either[Failure, Post]:
        ...

    @abstractmethod
    async def update_post(self, post: Post) -> Either[Failure, Post]:
        ...

    @abstractmethod
    async def delete_post(self, post_id: str) -> Either[Failure, Post]:
        ...

class BaseReadOnlyRepository(ABC):
    @abstractmethod
    async def view_posts(self) -> Either[Failure, Iterable[Post]]:
        ...

    @abstractmethod
    async def view_post(self, post_id: str) -> Either[Failure, Post]:
        ...


class BaseRepository(BaseReadOnlyRepository, BaseWriteOnlyRepository, ABC):
    ...
