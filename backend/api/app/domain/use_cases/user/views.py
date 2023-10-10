from typing import Iterable
from api.core.use_cases.use_case import UseCase, NoParams
from api.app.domain.repositories.user import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.post import Post

class ViewUsers(UseCase[Iterable[Post]]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: NoParams) -> Either[Failure, Iterable[Post]]:
        return await self.repository.view_users()