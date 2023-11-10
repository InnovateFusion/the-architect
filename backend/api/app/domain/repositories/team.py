from abc import ABC, abstractmethod
from typing import Iterable, List

from app.domain.entities.team import Team, TeamEntity
from app.domain.entities.user import UserEntity
from app.domain.repositories import ContextManagerRepository
from core.common.either import Either
from core.errors.failure import Failure


class BaseWriteOnlyRepository(ContextManagerRepository):
    @abstractmethod
    async def create_team(self, team: Team, user_id: str, user_ids: List[str]) -> Either[Failure, TeamEntity]:
        ...

    @abstractmethod
    async def update_team(self, team, team_id: str, user_id: str) -> Either[Failure, TeamEntity]:
        ...

    @abstractmethod
    async def delete_team(self, team_id: str) -> Either[Failure, TeamEntity]:
        ...

    @abstractmethod
    async def leave_team(self, team_id: str, user_id: str) -> Either[Failure, TeamEntity]:
        ...

    @abstractmethod
    async def join_team(self, team_id: str, user_id: str) -> Either[Failure, TeamEntity]:
        ...

    @abstractmethod
    async def add_team_member(self, team_id: str,  creator_id: str, user_ids: Iterable[str]) -> Either[Failure, TeamEntity]:
        ...

class BaseReadOnlyRepository(ABC):
    @abstractmethod
    async def view_teams(self, team_id: str) -> Either[Failure, Iterable[TeamEntity]]:
        ...

    @abstractmethod
    async def view_team(self, team_id: str) -> Either[Failure, TeamEntity]:
        ...

    @abstractmethod
    async def team_members(self, team_id: str) -> Either[Failure, Iterable[UserEntity]]:
        ...


class BaseRepository(BaseReadOnlyRepository, BaseWriteOnlyRepository, ABC):
    ...
