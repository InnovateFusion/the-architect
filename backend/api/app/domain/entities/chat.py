import json
from dataclasses import dataclass
from pydantic import BaseModel
from typing import List, Optional, Dict
from app.domain.entities.message import Message
from app.domain.entities import BaseEntity

class Chat(BaseModel):
    id: Optional[str]
    messages: List[Message]
    
class Notify(BaseModel):
    status: str
    generationTime: str
    id: str
    output: List[str]
    meta: Dict 

@dataclass
class ChatEntity(BaseEntity):
    id: Optional[str]
    title: str
    user_id: str
    messages: List[Message]

    def add_message(self, message: Message) -> None:
        self.messages.append(message)
    
    @classmethod
    def from_dict(cls, data: dict) -> 'ChatEntity':
        message_data = data.get('messages', [])
        messages = [Message.from_dict(msg) for msg in message_data]
        return cls(
            id=data.get('id'),
            title=data.get('title'),
            user_id=data.get('user_id'),
            messages=messages
        )
    
    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'title': self.title,
            'user_id': self.user_id,
            'messages': [msg.to_dict() for msg in self.messages]
        }
    
    def to_json(self) -> str:
        return json.dumps(self.to_dict())

    @classmethod
    def from_json(cls, json_str: str) -> 'ChatEntity':
        data = json.loads(json_str)
        return cls.from_dict(data)
