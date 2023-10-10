import datetime
import jwt
from sqlalchemy.orm import Session
from abc import ABC, abstractmethod
from typing import List
from app.domain.entities.auth import Auth, AuthEntity
from core.common.password import verify_password
from core.errors.exceptions import CacheException
from app.data.models.user import UserModel

SECRET_KEY = "09d25e094faa6ca2556c818166b7a9563b93f7099f6f0f4caa6cf63b88e8d3e7"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30000000

class AuthLocalDataSource(ABC):
    
    @abstractmethod
    async def get_token(self, user: Auth) -> AuthEntity:
        ...
                
class AuthLocalDataSourceImpl(AuthLocalDataSource):
    
    def __init__(self, db: Session):
        self.db = db
        
    async def get_token(self, user: Auth) -> AuthEntity:
        _user = self.db.query(UserModel).filter(UserModel.email == user['email']).first()
        if _user is None:
            raise CacheException("No user is found exists")
        if not verify_password(user['password'], _user.password):
            raise CacheException("Invalid password")
        expire = datetime.datetime.utcnow() + datetime.timedelta(minutes=15)
        to_encode = {"exp": expire, "email": _user.email, 'id': _user.id, 'first_name': _user.first_name, 'last_name': _user.last_name}
        encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
        
        return AuthEntity(access_token=encoded_jwt, token_type="bearer", id=_user.id)
    

        
        
        
            
