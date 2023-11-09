from typing import Iterable, List

from app.data.datasources.local.team import TeamLocalDataSource
from app.domain.entities.team import Team, TeamEntity
from app.domain.entities.user import UserEntity
from app.domain.repositories.team import BaseRepository
from core.common.either import Either
from core.errors.exceptions import CacheException
from core.errors.failure import CacheFailure, Failure


class TeamRepositoryImpl(BaseRepository):

    def __init__(self, team_local_datasource: TeamLocalDataSource):
        self.team_local_datasource = team_local_datasource

    async def create_team(self, team: Team, user_id: str, user_ids: List[str]) -> Either[Failure, TeamEntity]:
        try:
            team_entity = await self.team_local_datasource.create_team(team, user_id, user_ids)
            return Either.right(team_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def update_team(self, team: Team, team_id: str, user_id: str) -> Either[Failure, TeamEntity]:
        try:
            team_entity = await self.team_local_datasource.update_team(team, team_id, user_id)
            return Either.right(team_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def delete_team(self, team_id: str) -> Either[Failure, TeamEntity]:
        try:
            team_entity = await self.team_local_datasource.delete_team(team_id)
            return Either.right(team_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def view_teams(self, user_id: str) -> Either[Failure, list]:
        try:
            teams = await self.team_local_datasource.view_teams(user_id)
            return Either.right(teams)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def view_team(self, team_id: str) -> Either[Failure, TeamEntity]:
        try:
            team_entity = await self.team_local_datasource.view_team(team_id)
            return Either.right(team_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def join_team(self, team_id: str, user_id: str) -> Either[Failure, TeamEntity]:
        try:
            team_entity = await self.team_local_datasource.join_team(team_id, user_id)
            return Either.right(team_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def leave_team(self, team_id: str, user_id: str) -> Either[Failure, TeamEntity]:
        try:
            team_entity = await self.team_local_datasource.leave_team(team_id, user_id)
            return Either.right(team_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))

    async def team_members(self, team_id: str) -> Either[Failure, Iterable[UserEntity]]:
        try:
            team_entity = await self.team_local_datasource.team_members(team_id=team_id)
            return Either.right(team_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
        
    async def add_team_member(self, team_id: str,creator_id: str, user_ids: Iterable[str]) -> Either[Failure, TeamEntity]:
        try:
            team_entity = await self.team_local_datasource.add_team_member(team_id, creator_id, user_ids)
            return Either.right(team_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))