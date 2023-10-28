import datetime
from dataclasses import dataclass
from typing import List, Optional

from pydantic import BaseModel, validator

from app.domain.entities import BaseEntity

architecture_tags = [
    "exterior", "facade", "outdoor", "landscape", "architectural facade", "outdoor design",
    "interior", "indoor", "interior design", "space planning", "furniture design", "decor", "lighting"
]


class Post(BaseModel):
    id = Optional[str]
    userId: Optional[str]
    image: str
    title: str
    content: Optional[str]
    tags: List[str]

    @validator('tags', pre=True, always=True)
    def validate_tags(cls, v):
        invalid_tags = [tag for tag in v if tag not in architecture_tags]
        if invalid_tags:
            raise ValueError(f"Invalid tags: {', '.join(invalid_tags)}")
        return v

    class Config:
        arbitrary_types_allowed = True


@dataclass
class PostEntity(BaseEntity):
    id: Optional[str]
    userId: Optional[str]
    image: Optional[str]
    firstName: Optional[str]
    lastName: Optional[str]
    userImage: Optional[str]
    title: str
    content: str
    date: datetime.datetime
    like: int
    clone: int
    isLiked: bool
    isCloned: bool
    tags: List[str]

    @classmethod
    def from_dict(cls, data: dict) -> 'PostEntity':
        return cls(
            id=data.get('id'),
            userId=data.get('userId'),
            image=data.get('image'),
            firstName=data.get('firstName'),
            lastName=data.get('lastName'),
            title=data.get('title'),
            content=data.get('content'),
            userImage=data.get('userImage'),
            date=data.get('date'),
            like=data.get('like'),
            clone=data.get('clone'),
            isLiked=data.get('isLiked'),
            isCloned=data.get('isCloned'),
            tags=data.get('tags', [])
        )

    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'userId': self.userId,
            'image': self.image,
            'firstName': self.firstName,
            'lastName': self.lastName,
            'title': self.title,
            'content': self.content,
            'date': self.date,
            'userImage': self.userImage,
            'like': self.like,
            'clone': self.clone,
            'isLiked': self.isLiked,
            'isCloned': self.isCloned,
            'tags': self.tags
        }
