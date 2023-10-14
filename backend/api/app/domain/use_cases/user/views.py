from typing import Iterable
from core.use_cases.use_case import UseCase, NoParams
from app.domain.repositories.user import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.user import UserEntity

class ViewUsers(UseCase[Iterable[UserEntity]]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: NoParams) -> Either[Failure, Iterable[UserEntity]]:
        return await self.repository.view_users()