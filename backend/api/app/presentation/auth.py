from fastapi import HTTPException, APIRouter, Depends, HTTPException, status
from app.data.datasources.local.auth import AuthLocalDataSourceImpl
from app.domain.repositories.auth import BaseRepository as AuthRepository
from app.data.repositories.auth import AuthRepositoryImpl
from app.domain.entities.auth import Auth
from core.config.database_config import get_db
from sqlalchemy.orm.session import Session
from pydantic import BaseModel


class AuthResponse(BaseModel):
    access_token: str
    token_type: str

    class Config:
        arbitrary_types_allowed = True
        
router = APIRouter()

def get_repository(db: Session = Depends(get_db)):
    auth_local_datasource = AuthLocalDataSourceImpl(db=db)
    return AuthRepositoryImpl(auth_local_datasource)

@router.post("/token/", response_model=AuthResponse)
async def get_token(
    auth: Auth,
    repository: AuthRepository = Depends(get_repository)

):
    result = await repository.get_auth(auth)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password",
            headers={"WWW-Authenticate": "Bearer"},
        )

