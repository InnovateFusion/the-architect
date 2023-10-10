from core.use_cases.use_case import UseCase
from app.domain.repositories.auth import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.auth import Auth, AuthEntity

class Params(Equatable):
    def __init__(self, auth: AuthEntity) -> None:
        self.auth = auth


class CreateChat(UseCase[Auth]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Auth]:
        return await self.repository.get_auth(params.auth)