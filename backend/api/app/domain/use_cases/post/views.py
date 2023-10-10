from typing import Iterable
from core.use_cases.use_case import UseCase, NoParams
from app.domain.repositories.post import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.post import Post

class ViewPosts(UseCase[Iterable[Post]]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: NoParams) -> Either[Failure, Iterable[Post]]:
        return await self.repository.view_posts()