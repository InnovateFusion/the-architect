from uuid import uuid4
from sqlalchemy.orm import Session
from abc import ABC, abstractmethod
from typing import List
from app.domain.entities.user import User, UserEntity
from core.common.password import get_password_hash
from core.errors.exceptions import CacheException
from app.data.models.user import UserModel

class UserLocalDataSource(ABC):
    
    @abstractmethod
    async def create_user(self, user: User) -> UserEntity:
        ...

    @abstractmethod
    async def update_user(self, user: User) -> UserEntity:
        ...
    
    @abstractmethod
    async def delete_user(self, user_id: str) -> UserEntity:
        ...
        
    @abstractmethod
    async def view_users(self) -> List[UserEntity]:
        ...
        
    @abstractmethod
    async def view_user(self, user_id: str) -> UserEntity:
        ...
        
class UserLocalDataSourceImpl(UserLocalDataSource):
    
    def __init__(self, db: Session):
        self.db = db
        
    async def create_user(self, user: User) -> UserEntity:
        _user = self.db.query(UserModel).filter(UserModel.email == user['email']).first()
        if _user is not None:
            raise CacheException("User already exists")
        if len(user['password']) < 8:
            raise CacheException("Password length atleast 8 characters")
    
        _user = UserModel(
            id=str(uuid4()),
            first_name=user['firstName'],
            last_name=user['lastName'],
            bio=user['bio'],
            email=user['email'],
            password=get_password_hash(user['password']),
            country=user['country']
        )
        
        self.db.add(_user)
        self.db.commit()
        return UserEntity(
            id=_user.id,
            firstName=_user.first_name,
            lastName=_user.last_name,
            bio=_user.bio,
            email=_user.email,
            password=_user.password,
            country=_user.country,
            followers=_user.get_followers_count(self.db),
            following=_user.get_following_count(self.db)
        )
    
    async def update_user(self, user: User) -> UserEntity:
        _user = self.db.query(UserModel).filter(UserModel.id == user['id']).first()
        if _user is None:
            raise CacheException("User not found")
        _user.first_name = user['firstName']
        _user.last_name = user['lastName']
        _user.bio = user['bio']
        _user.password = user['password']
        _user.country = user['country']
        self.db.commit()
        return UserEntity(
            id=_user.id,
            firstName=_user.first_name,
            lastName=_user.last_name,
            bio=_user.bio,
            email=_user.email,
            password=_user.password,
            country=_user.country,
            followers=_user.get_followers_count(self.db),
            following=_user.get_following_count(self.db)
        )
    
    async def delete_user(self, user_id: str) -> UserEntity:
        user = self.db.query(UserModel).filter(UserModel.id == user_id).first()
        if user is None:
            raise CacheException("User not found")
        self.db.delete(user)
        self.db.commit()
        return UserEntity(
            id=user.id,
            firstName=user.first_name,
            lastName=user.last_name,
            bio=user.bio,
            email=user.email,
            password=user.password,
            country=user.country,
            followers=user.get_followers_count(self.db),
            following=user.get_following_count(self.db)
        )
    
    async def view_users(self) -> List[UserEntity]:
        users = self.db.query(UserModel).all()
        if users is None:
            raise CacheException("Users not found")
        return [
            UserEntity(
                id=user.id,
                firstName=user.first_name,
                lastName=user.last_name,
                bio=user.bio,
                email=user.email,
                password=user.password,
                country=user.country,
                followers=user.get_followers_count(self.db),
                following=user.get_following_count(self.db)
            ) for user in users
        ]
        
    async def view_user(self, user_id: str) -> UserEntity:
        user = self.db.query(UserModel).filter(UserModel.id == user_id).first()
        if user is None:
            raise CacheException("User not found")
        return UserEntity(
            id=user.id,
            firstName=user.first_name,
            lastName=user.last_name,
            bio=user.bio,
            email=user.email,
            password=user.password,
            country=user.country,
            followers=user.get_followers_count(self.db),
            following=user.get_following_count(self.db)
        )
