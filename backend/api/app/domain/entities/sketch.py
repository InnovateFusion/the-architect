from dataclasses import dataclass
from typing import Optional

from app.domain.entities import BaseEntity
from pydantic import BaseModel


class Sketch(BaseModel):
    title: str
    class Config:
        arbitrary_types_allowed = True

@dataclass
class SketchEntity(BaseEntity):
    id: Optional[str]
    title: str

    @classmethod
    def from_dict(cls, adict):
        return cls(**adict)
    
    def to_dict(self):
        return {
            "id": self.id,
            "title": self.title
        }
