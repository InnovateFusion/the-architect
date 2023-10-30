from datetime import datetime
from typing import List, Optional

from app.data.datasources.local.post import PostLocalDataSourceImpl
from app.data.repositories.post import PostRepositoryImpl
from app.domain.entities.post import Post
from app.domain.entities.user import User
from app.domain.repositories.post import BaseRepository as PostRepository
from app.domain.use_cases.post.all_posts import AllPost
from app.domain.use_cases.post.all_posts import Params as AllPostParams
from app.domain.use_cases.post.create import CreatePost
from app.domain.use_cases.post.create import Params as CreatePostParams
from app.domain.use_cases.post.delete import DeletePost
from app.domain.use_cases.post.delete import Params as DeletePostParams
from app.domain.use_cases.post.status import ClonePost, LikePost
from app.domain.use_cases.post.status import Params as StatusParams
from app.domain.use_cases.post.status import UnclonePost, UnlikePost
from app.domain.use_cases.post.update import Params as UpdatePostParams
from app.domain.use_cases.post.update import UpdatePost
from app.domain.use_cases.post.view import Params as ViewPostParams
from app.domain.use_cases.post.view import ViewPost
from app.domain.use_cases.post.views import Params as ViewPostsParams
from app.domain.use_cases.post.views import ViewPosts
from core.common.current_user import get_current_user
from core.config.database_config import get_db
from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel
from sqlalchemy.orm.session import Session


class PostResponse(BaseModel):
    id: Optional[str]
    userId: Optional[str]
    image: Optional[str]
    firstName: Optional[str]
    lastName: Optional[str]
    title: str
    content: str
    date: datetime
    userImage: Optional[str]
    like: int
    clone: int
    isLiked: bool
    isCloned: bool
    tags: List[str]


router = APIRouter()


def get_repository(db: Session = Depends(get_db)):
    post_local_datasource = PostLocalDataSourceImpl(db=db)
    return PostRepositoryImpl(post_local_datasource)


@router.get("/posts/all", response_model=List[PostResponse])
async def all_posts(
    skip: int = Query(0, description="Number of items to skip"),
    limit: int = Query(10, description="Number of items to return per page"),
    tags: List[str] = Query([]),
    search_word: str = "",
    repository: PostRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    all_posts_use_case = AllPost(repository)
    params = AllPostParams(
        tags=tags, search_word=search_word, skip=skip, limit=limit, user_id=current_user.id)
    result = await all_posts_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=404, detail=result.get().error_message)


@router.post("/posts/", response_model=PostResponse)
async def create_post(
    post: Post,
    repository: PostRepository = Depends(get_repository),
):
    create_post_use_case = CreatePost(repository)
    params = CreatePostParams(post=post)
    result = await create_post_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.put("/posts/{post_id}", response_model=PostResponse)
async def update_post(
    post_id: str,
    post: Post,
    repository: PostRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    update_post_use_case = UpdatePost(repository)
    params = UpdatePostParams(post=post, post_id=post_id)
    result = await update_post_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.delete("/posts/{post_id}", response_model=PostResponse)
async def delete_post(
    post_id: str,
    repository: PostRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    delete_post_use_case = DeletePost(repository)
    params = DeletePostParams(post_id=post_id)
    result = await delete_post_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/users/{user_id}/posts", response_model=List[PostResponse])
async def view_all_posts(
    user_id: str,
    repository: PostRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    view_all_posts_use_case = ViewPosts(repository)
    params = ViewPostsParams(user_id=user_id)
    result = await view_all_posts_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/posts/{post_id}", response_model=PostResponse)
async def view_post(
    post_id: str,
    repository: PostRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    view_post_use_case = ViewPost(repository)
    params = ViewPostParams(post_id=post_id)
    result = await view_post_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=404, detail=result.get().error_message)


@router.get("/posts/{post_id}/like/", response_model=PostResponse)
async def like_post(
    post_id: str,
    repository: PostRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    like_post_use_case = LikePost(repository)
    params = StatusParams(post_id=post_id, user_id=current_user.id)
    result = await like_post_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/posts/{post_id}/unlike/", response_model=PostResponse)
async def unlike_post(
    post_id: str,
    repository: PostRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    unlike_post_use_case = UnlikePost(repository)
    params = StatusParams(post_id=post_id, user_id=current_user.id)
    result = await unlike_post_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/posts/{post_id}/clone/", response_model=PostResponse)
async def clone_post(
    post_id: str,
    repository: PostRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    clone_post_use_case = ClonePost(repository)
    params = StatusParams(post_id=post_id, user_id=current_user.id)
    result = await clone_post_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/posts/{post_id}/unclone/", response_model=PostResponse)
async def unclone_post(
    post_id: str,
    repository: PostRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    unclone_post_use_case = UnclonePost(repository)
    params = StatusParams(post_id=post_id, user_id=current_user.id)
    result = await unclone_post_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
