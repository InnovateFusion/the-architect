from dataclasses import dataclass
import datetime
from typing import Optional

@dataclass
class Post:
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

    @classmethod
    def from_dict(cls, data: dict) -> 'Post':
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
            cloned=data.get('clone'),
            isLiked=data.get('isLiked'),
            isCloned=data.get('isCloned')
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
            'isCloned': self.isCloned
        }
