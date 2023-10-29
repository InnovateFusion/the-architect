from dataclasses import dataclass
from typing import Optional

from app.domain.entities import BaseEntity
from pydantic import BaseModel


class User(BaseModel):
    firstName: str
    lastName: str
    bio: Optional[str]
    email: str
    password: Optional[str]
    Optional[str]
    country: Optional[str]
    image: Optional[str]


class UpdatUserRequest(BaseModel):
    firstName: Optional[str]
    lastName: Optional[str]
    bio: Optional[str]
    email: Optional[str]
    country: Optional[str]
    image: Optional[str]


@dataclass
class UserEntity(BaseEntity):
    id: Optional[str]
    firstName: str
    lastName: str
    bio: Optional[str]
    email: str
    password: Optional[str]
    image: Optional[str]
    country: Optional[str]
    followers: Optional[int]
    following: Optional[int]

    @classmethod
    def from_dict(cls, data: dict) -> 'UserEntity':
        return cls(
            id=data.get('id'),
            firstName=data.get('firstName'),
            lastName=data.get('lastName'),
            bio=data.get('bio'),
            email=data.get('email'),
            image=data.get('image'),
            password=data.get('password'),
            country=data.get('country'),
            followers=data.get('followers', 0),
            following=data.get('following', 0)
        )

    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'firstName': self.firstName,
            'lastName': self.lastName,
            'bio': self.bio,
            'email': self.email,
            'password': self.password,
            'image': self.image,
            'country': self.country,
            'followers': self.followers,
            'following': self.following
        }
