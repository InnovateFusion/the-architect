from abc import ABC, abstractmethod
from typing import Iterable
from app.domain.entities.post import Post
from app.domain.repositories import ContextManagerRepository
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

    @abstractmethod
    async def like_post(self, post_id: str, user_id: str) -> Either[Failure, None]:
        ...

    @abstractmethod
    async def unlike_post(self, post_id: str, user_id: str) -> Either[Failure, None]:
        ...

    @abstractmethod
    async def clone_post(self, post_id: str, user_id: str) -> Either[Failure, None]:
        ...

    @abstractmethod
    async def unclone_post(self, post_id: str, user_id: str) -> Either[Failure, None]:
        ...

class BaseReadOnlyRepository(ABC):
    @abstractmethod
    async def view_posts(self, user_id: str) -> Either[Failure, Iterable[Post]]:
        ...

    @abstractmethod
    async def view_post(self, post_id: str) -> Either[Failure, Post]:
        ...

class BaseRepository(BaseReadOnlyRepository, BaseWriteOnlyRepository, ABC):
    ...
