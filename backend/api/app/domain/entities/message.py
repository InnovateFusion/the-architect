import json
from dataclasses import dataclass
from pydantic import BaseModel
from app.domain.entities import BaseEntity

class Message(BaseModel):
    user_id: str
    payload: dict
    model: str

@dataclass
class MessageEntity(BaseEntity):
    id: str
    sender: str
    content: str
    userImage: str
    date: str
    
    @classmethod
    def from_dict(cls, data: dict) -> 'MessageEntity':
        return cls(
            id=data.get('id'),
            sender=data.get('sender'),
            content=data.get('content'),
            userImage = data.get('userImage'),
            date=data.get('date')
        )
    
    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'sender': self.sender,
            'content': self.content,
            'userImage': self.userImage,
            'date': str(self.date)
        }
    
    def to_json(self) -> str:
        return json.dumps(self.to_dict())

    @classmethod
    def from_json(cls, json_str: str) -> 'MessageEntity':
        data = json.loads(json_str)
        return cls.from_dict(data)
