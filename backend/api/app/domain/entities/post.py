from dataclasses import dataclass
import datetime
from typing import Optional, List
from app.domain.entities import BaseEntity

class Post(dict):
    userId: Optional[str]
    image: Optional[str]
    title: str
    content: str
    tags: List[str] 

@dataclass
class PostEntity(BaseEntity):
    id: Optional[str]
    userId: Optional[str]
    image: Optional[str]
    firstName: Optional[str]
    lastName: Optional[str]
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
            'like': self.like,
            'clone': self.clone,
            'isLiked': self.isLiked,
            'isCloned': self.isCloned,
            'tags': self.tags  
        }