from fastapi import HTTPException, APIRouter, Depends
from typing import Annotated, List, Optional
from app.data.datasources.local.user import UserLocalDataSourceImpl
from app.domain.repositories.user import BaseRepository as UserRepository
from app.data.repositories.user import UserRepositoryImpl
from app.domain.entities.user import User
from app.domain.use_cases.user.create import CreateUser, Params as CreateUserParams
from app.domain.use_cases.user.delete import DeleteUser, Params as DeleteUserParams
from app.domain.use_cases.user.update import UpdateUser, Params as UpdateUserParams
from app.domain.use_cases.user.view import ViewUser, Params as ViewUserParams
from app.domain.use_cases.user.views import ViewUsers
from core.common.current_user import get_current_user
from core.config.database_config import get_db
from sqlalchemy.orm.session import Session
from pydantic import BaseModel

from core.use_cases.use_case import NoParams

class UserResponse(BaseModel):
    id: str
    firstName: str
    lastName: str
    bio: str
    email: str
    country: str
    followers: Optional[int]
    following: Optional[int]

    class Config:
        arbitrary_types_allowed = True

router = APIRouter()

def get_repository(db: Session = Depends(get_db)):
    user_local_datasource = UserLocalDataSourceImpl(db=db)
    return UserRepositoryImpl(user_local_datasource)

@router.post("/users/", response_model=UserResponse)
async def create_user(
    user: User,
    repository: UserRepository = Depends(get_repository),
):
    create_user_use_case = CreateUser(repository)
    params = CreateUserParams(user=user)
    result = await create_user_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)

@router.put("/users/{user_id}", response_model=UserResponse)
async def update_user(
    user_id: str,
    user: User,
    repository: UserRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    update_user_use_case = UpdateUser(repository)
    user['id'] = user_id
    params = UpdateUserParams(user=user)
    result = await update_user_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)

@router.delete("/users/{user_id}", response_model=UserResponse)
async def delete_user(
    user_id: str,
    repository: UserRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    delete_user_use_case = DeleteUser(repository)
    params = DeleteUserParams(user_id=user_id)
    result = await delete_user_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)

@router.get("/users/", response_model=List[UserResponse])
async def view_all_users(
    repository: UserRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    view_all_users_use_case = ViewUsers(repository)
    params = NoParams()
    result = await view_all_users_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)

@router.get("/users/{user_id}", response_model=UserResponse)
async def view_user(
    user_id: str,
    repository: UserRepository = Depends(get_repository),  
    current_user: User = Depends(get_current_user)
):
    view_user_use_case = ViewUser(repository)
    params = ViewUserParams(user_id=user_id)
    result = await view_user_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=404, detail=result.get().error_message)

@router.get("/users/me/", response_model=UserResponse)
async def read_users_me(
    current_user: Annotated[User, Depends(get_current_user)]
):
    return current_user