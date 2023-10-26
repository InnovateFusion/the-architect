from abc import ABC, abstractmethod
from typing import Iterable, List
from app.domain.entities.post import Post, PostEntity
from app.domain.repositories import ContextManagerRepository
from core.common.either import Either
from core.errors.failure import Failure

class BaseWriteOnlyRepository(ContextManagerRepository):
    @abstractmethod
    async def create_post(self, post: Post) -> Either[Failure, PostEntity]:
        ...

    @abstractmethod
    async def update_post(self, post: Post) -> Either[Failure, PostEntity]:
        ...

    @abstractmethod
    async def delete_post(self, post_id: str) -> Either[Failure, PostEntity]:
        ...

    @abstractmethod
    async def like_post(self, post_id: str, user_id: str) -> Either[Failure, PostEntity]:
        ...

    @abstractmethod
    async def unlike_post(self, post_id: str, user_id: str) -> Either[Failure, PostEntity]:
        ...

    @abstractmethod
    async def clone_post(self, post_id: str, user_id: str) -> Either[Failure, PostEntity]:
        ...

    @abstractmethod
    async def unclone_post(self, post_id: str, user_id: str) -> Either[Failure, PostEntity]:
        ...

    @abstractmethod
    async def all_posts(self, tags: List[str], search_word: str, skip: int, limit: int) -> Either[Failure, Iterable[PostEntity]]:
        ...

class BaseReadOnlyRepository(ABC):
    @abstractmethod
    async def view_posts(self, user_id: str) -> Either[Failure, Iterable[PostEntity]]:
        ...

    @abstractmethod
    async def view_post(self, post_id: str) -> Either[Failure, PostEntity]:
        ...
        

class BaseRepository(BaseReadOnlyRepository, BaseWriteOnlyRepository, ABC):
    ...
