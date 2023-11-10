from abc import ABC, abstractmethod
from typing import List

from core.errors.exceptions import CacheException
from app.data.models.team import SketchModel, TeamModel, UserTeamModel
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.sketch import SketchEntity, Sketch
from uuid import uuid4

class SketchLocalDataSource(ABC):

    @abstractmethod
    async def create_sketch(self, sketch: Sketch, team_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        ...
        
    @abstractmethod
    async def update_sketch(self, sketch: Sketch, sketch_id: str, team_id: str,  user_id: str) -> Either[Failure, SketchEntity]:
        ...

    @abstractmethod
    async def delete_sketch(self, sketch_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        ...

    @abstractmethod
    async def views_sketch(self, team_id: str, user_id: str) -> Either[Failure, List[SketchEntity]]:
        ...

    @abstractmethod
    async def view_sketch(self, sketch_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        ...


class SketchLocalDataSourceImpl(SketchLocalDataSource):
    
    def __init__(self, db):
        self.db = db
        
    async def create_sketch(self, sketch: Sketch, team_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        existing_team = self.db.query(TeamModel).filter(
            TeamModel.id == team_id).first()
        if not existing_team:
            raise CacheException("Team does not exist")
        
        user_team_exists = self.db.query(UserTeamModel).filter(
            UserTeamModel.user_id == user_id, UserTeamModel.team_id == team_id
        ).first()
        
        if not user_team_exists:
            raise CacheException("User is not a member of the team")

        _sketch = SketchModel(
            id=str(uuid4()),
            team_id=team_id,
            name=sketch.title
        )
        self.db.add(_sketch)
        self.db.commit()
        
        return SketchEntity(
            id=_sketch.id,
            title=_sketch.name
        )
        
    async def update_sketch(self, sketch: Sketch, sketch_id: str, team_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        existing_team = self.db.query(TeamModel).filter(TeamModel.id == team_id).first()
        if not existing_team:
            raise CacheException("Team does not exist")
        
        user_team_exists = self.db.query(UserTeamModel).filter(
            UserTeamModel.user_id == user_id, UserTeamModel.team_id == team_id
        ).first()
        
        if not user_team_exists:
            raise CacheException("User is not a member of the team")

        existing_sketch = self.db.query(SketchModel).filter(SketchModel.id == sketch_id).first()
        if not existing_sketch:
            raise CacheException("Sketch does not exist")

        existing_sketch.name = sketch.title
        self.db.commit()
        return SketchEntity(
            id=existing_sketch.id,
            title=existing_sketch.name
        )
        
    async def delete_sketch(self, sketch_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        existing_sketch = self.db.query(SketchModel).filter(SketchModel.id == sketch_id).first()
        if not existing_sketch:
            raise CacheException("Sketch does not exist")
        
        user_team_exists = self.db.query(UserTeamModel).filter(
            UserTeamModel.user_id == user_id, UserTeamModel.team_id == existing_sketch.team_id
        ).first()
        
        if not user_team_exists:
            raise CacheException("User is not a member of the team")
        
        self.db.delete(existing_sketch)
        self.db.commit()

        return SketchEntity(
            id=existing_sketch.id,
            title=existing_sketch.name
        )

    async def views_sketch(self, team_id: str, user_id: str) -> Either[Failure, List[SketchEntity]]:
        existing_team = self.db.query(TeamModel).filter(TeamModel.id == team_id).first()
        if not existing_team:
            raise CacheException("Team does not exist")
        
        user_team_exists = self.db.query(UserTeamModel).filter(
            UserTeamModel.user_id == user_id, UserTeamModel.team_id == team_id
        ).first()
        
        if not user_team_exists:
            raise CacheException("User is not a member of the team")

        sketches = self.db.query(SketchModel).filter(SketchModel.team_id == team_id).all()

        return [SketchEntity(id=sketch.id, title=sketch.name) for sketch in sketches]

    async def view_sketch(self, sketch_id: str, user_id: str) -> Either[Failure, SketchEntity]:
        existing_sketch = self.db.query(SketchModel).filter(SketchModel.id == sketch_id).first()
        if not existing_sketch:
            raise  CacheException("Sketch does not exist")

        team_id_of_sketch = existing_sketch.team_id
        user_team_exists = self.db.query(UserTeamModel).filter(UserTeamModel.user_id == user_id, UserTeamModel.team_id == team_id_of_sketch).first()
        if not user_team_exists:
            raise CacheException("User is not a member of the team for this sketch")

        return SketchEntity(id=existing_sketch.id, title=existing_sketch.name)
