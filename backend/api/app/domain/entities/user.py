from dataclasses import dataclass
from typing import Optional, TypedDict
from app.domain.entities import BaseEntity

class User(TypedDict):
    id: Optional[str]
    firstName: str
    lastName: str
    bio: Optional[str]
    email: str
    password: str
    country: Optional[str]
    followers: int
    following: int

@dataclass
class UserEntity(BaseEntity):
    id: Optional[str]
    firstName: str
    lastName: str
    bio: Optional[str]
    email: str
    password: str
    country: Optional[str]
    followers: int
    following: int

    @classmethod
    def from_dict(cls, data: dict) -> 'UserEntity':
        return cls(
            id=data.get('id'),
            firstName=data.get('firstName'),
            lastName=data.get('lastName'),
            bio=data.get('bio'),
            email=data.get('email'),
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
            'country': self.country,
            'followers': self.followers,
            'following': self.following
        }
