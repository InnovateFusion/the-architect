from typing import Iterable
from core.common.equatable import Equatable
from core.use_cases.use_case import UseCase
from app.domain.repositories.post import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.post import Post, PostEntity

class Params(Equatable):
    def __init__(self, user_id: str) -> None:
        self.user_id = user_id

class ViewPosts(UseCase[Iterable[PostEntity]]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Iterable[PostEntity]]:
        return await self.repository.view_posts(params.user_id)