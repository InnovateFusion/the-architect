from core.use_cases.use_case import UseCase
from app.domain.repositories.user import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.user import  UserEntity

class Params(Equatable):
    def __init__(self, user_id: str) -> None:
        self.user_id = user_id
        
class ViewUser(UseCase[UserEntity]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, UserEntity]:
        return await self.repository.view_user(params.user_id)
