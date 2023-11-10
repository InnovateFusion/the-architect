from dataclasses import dataclass
from typing import Optional

from app.domain.entities import BaseEntity
from pydantic import BaseModel


class Free(BaseModel):
    prompt: Optional[str]

    class Config:
        arbitrary_types_allowed = True


@dataclass
class FreeEntity(BaseEntity):
    id: str
    image: Optional[str]
    prompt: Optional[str]

    @classmethod
    def from_dict(cls, data: dict) -> 'FreeEntity':
        return cls(
            id=data.get('id'),
            image=data.get('image'),
            prompt=data.get('prompt')
        )

    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'image': self.image,
            'prompt': self.prompt
        }
