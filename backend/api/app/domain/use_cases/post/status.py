from core.use_cases.use_case import UseCase
from app.domain.repositories.post import BaseRepository
from core.common.equatable import Equatable
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.post import Post, PostEntity

class Params(Equatable):
    def __init__(self, post_id: str, user_id: str) -> None:
        self.post_id = post_id
        self.user_id = user_id


class LikePost(UseCase[Post]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Post]:
        return await self.repository.like_post(params.post_id, params.user_id)

class UnlikePost(UseCase[Post]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Post]:
        return await self.repository.unlike_post(params.post_id, params.user_id)
    
class ClonePost(UseCase[Post]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Post]:
        return await self.repository.clone_post(params.post_id, params.user_id)

class UnclonePost(UseCase[Post]):
    def __init__(self, repository: BaseRepository):
        self.repository = repository
    
    async def __call__(self, params: Params) -> Either[Failure, Post]:
        return await self.repository.unclone_post(params.post_id, params.user_id)
