from core.use_cases.use_case import UseCase
from app.domain.repositories.post import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.post import Post, PostEntity

class Params(Equatable):
    def __init__(self, post: Post, post_id: str) -> None:
        self.post = post
        self.post_id = post_id
        
class UpdatePost(UseCase[PostEntity]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, PostEntity]:
        return await self.repository.update_post(params.post, params.post_id)