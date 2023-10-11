import json
from dataclasses import dataclass
from typing import TypedDict
from api.app.domain.entities import BaseEntity

class Message(TypedDict):
    id: str
    sender: str  
    content: str 
    date: str

@dataclass
class MessageEntity(BaseEntity):
    id: str
    sender: str  
    content: str 
    date: str
    
    @classmethod
    def from_dict(cls, data: dict) -> 'MessageEntity':
        return cls(
            id=data.get('id'),
            sender=data.get('sender'),
            content=data.get('content'),
            date=data.get('date')
        )
    
    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'sender': self.sender,
            'content': self.content,
            'date': self.date
        }
    
    def to_json(self) -> str:
        return json.dumps(self.to_dict())

    @classmethod
    def from_json(cls, json_str: str) -> 'MessageEntity':
        data = json.loads(json_str)
        return cls.from_dict(data)