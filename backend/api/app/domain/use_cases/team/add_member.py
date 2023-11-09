from typing import List

from app.domain.entities.team import TeamEntity
from app.domain.repositories.team import BaseRepository
from core.common.either import Either
from core.common.equatable import Equatable
from core.errors.failure import Failure
from core.use_cases.use_case import UseCase


class Params(Equatable):
    def __init__(self, team_id: str,  creator_id: str, user_ids: List[str]) -> None:
        self.creator_id = creator_id
        self.team_id = team_id
        self.user_ids = user_ids

class AddTeamMember(UseCase[TeamEntity]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, TeamEntity]:
        return await self.repository.add_team_member(params.team_id,  params.creator_id, params.user_ids)