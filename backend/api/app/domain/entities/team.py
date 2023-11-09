from dataclasses import dataclass
from typing import Optional

from app.domain.entities import BaseEntity
from pydantic import BaseModel


class Team(BaseModel):
    title: Optional[str]
    description: Optional[str]
    image: Optional[str]
    user_ids: Optional[list[str]]

    class Config:
        arbitrary_types_allowed = True


@dataclass
class TeamEntity(BaseEntity):
    id: Optional[str]
    title: str
    description: Optional[str]
    creator_id: Optional[str]
    first_name: Optional[str]
    last_name: Optional[str]
    creator_image: Optional[str]
    image: Optional[str]
    create_at: str

    @classmethod
    def from_dict(cls, data: dict) -> 'TeamEntity':
        return cls(
            id=data.get('id'),
            title=data.get('title'),
            description=data.get('description'),
            creator_id=data.get('creator_id'),
            first_name=data.get('first_name'),
            last_name=data.get('last_name'),
            creator_image=data.get('creator_image'),
            image=data.get('image'),
            create_at=data.get('create_at')
        )

    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'title': self.title,
            'description': self.description,
            'creator_id': self.creator_id,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'creator_image': self.creator_image,
            'image': self.image,
            'create_at': self.create_at
        }
