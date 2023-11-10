from abc import ABC, abstractmethod
from typing import Iterable
from app.domain.entities.sketch import SketchEntity, Sketch
from app.domain.repositories import ContextManagerRepository
from core.common.either import Either
from core.errors.failure import Failure


class BaseWriteOnlyRepository(ContextManagerRepository):
    @abstractmethod
    async def create_sketch(self, sketch: Sketch, team_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        ...

    @abstractmethod
    async def update_sketch(self, sketch: Sketch, sketch_id: str, team_id: str,  user_id: str) -> Either[Failure, SketchEntity]:
        ...

    @abstractmethod
    async def delete_sketch(self, sketch_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        ...


class BaseReadOnlyRepository(ABC):
    @abstractmethod
    async def views_sketch(self, team_id: str, user_id: str) -> Either[Failure, Iterable[SketchEntity]]:
        ...

    @abstractmethod
    async def view_sketch(self, sketch_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        ...

class BaseRepository(BaseReadOnlyRepository, BaseWriteOnlyRepository, ABC):
    ...
