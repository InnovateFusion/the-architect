from core.use_cases.use_case import UseCase
from app.domain.repositories.team import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.team import TeamEntity

class Params(Equatable):
    def __init__(self, team_id: str, user_id: str) -> None:
        self.team_id = team_id
        self.user_id = user_id

class LeaveTeam(UseCase[TeamEntity]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, TeamEntity]:
        return await self.repository.leave_team(params.team_id, params.user_id)

