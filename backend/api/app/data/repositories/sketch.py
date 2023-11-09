from typing import Iterable

from app.data.datasources.local.sketch import SketchLocalDataSource
from app.domain.entities.sketch import Sketch, SketchEntity
from app.domain.repositories.sketch import BaseRepository
from core.common.either import Either
from core.errors.exceptions import CacheException
from core.errors.failure import CacheFailure, Failure


class SketchRepositoryImpl(BaseRepository):
    
    def __init__(self, sketch_local_datasource: SketchLocalDataSource):
        self.sketch_local_datasource = sketch_local_datasource

    async def create_sketch(self, sketch: Sketch, team_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        try:
            sketch_entity = await self.sketch_local_datasource.create_sketch(team_id=team_id, user_id=user_id, sketch=sketch)
            return Either.right(sketch_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def update_sketch(self, sketch: Sketch, sketch_id: str, team_id: str,  user_id: str) -> Either[Failure, SketchEntity]:
        try:
            sketch_entity = await self.sketch_local_datasource.update_sketch(team_id=team_id, user_id=user_id, sketch=sketch, sketch_id=sketch_id)
            return Either.right(sketch_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def delete_sketch(self, sketch_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        try:
            sketch_entity = await self.sketch_local_datasource.delete_sketch(sketch_id=sketch_id, user_id=user_id)
            return Either.right(sketch_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def views_sketch(self, team_id: str, user_id: str) -> Either[Failure, Iterable[SketchEntity]]:
        try:
            sketch_entity = await self.sketch_local_datasource.views_sketch(team_id=team_id, user_id=user_id)
            return Either.right(sketch_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def view_sketch(self, sketch_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        try:
            sketch_entity = await self.sketch_local_datasource.view_sketch(sketch_id=sketch_id, user_id=user_id)
            return Either.right(sketch_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))