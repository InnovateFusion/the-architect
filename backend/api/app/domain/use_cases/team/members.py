from typing import Iterable

from app.domain.entities.user import UserEntity
from app.domain.repositories.team import BaseRepository
from core.common.either import Either
from core.common.equatable import Equatable
from core.errors.failure import Failure
from core.use_cases.use_case import UseCase


class Params(Equatable):
    def __init__(self, team_id: str) -> None:
        self.team_id = team_id


class TeamMembers(UseCase[Iterable[UserEntity]]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository

    async def __call__(self, params: Params) -> Either[Failure, UserEntity]:
        return await self.repository.team_members(params.team_id)
