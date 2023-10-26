from typing import Iterable, List
from core.common.equatable import Equatable
from core.use_cases.use_case import UseCase
from app.domain.repositories.post import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.post import PostEntity

class Params(Equatable):
    def __init__(self,  tags: List[str], search_word: str, skip:int, limit: int) -> None:
        self.tags = tags
        self.search_word = search_word
        self.skip = skip
        self.limit = limit
        
class AllPost(UseCase[Iterable[PostEntity]]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Iterable[PostEntity]]:
        return await self.repository.all_posts(params.tags, params.search_word, params.skip, params.limit)
    
    
