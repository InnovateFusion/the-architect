import json
from dataclasses import dataclass
from typing import List, Optional
from api.app.domain.entities.message import Message

@dataclass
class Chat:
    id: Optional[str]
    messages: List[Message]

    def add_message(self, message: Message) -> None:
        self.messages.append(message)
    
    @classmethod
    def from_dict(cls, data: dict) -> 'Chat':
        message_data = data.get('messages', [])
        messages = [Message.from_dict(msg) for msg in message_data]
        return cls(
            id=data.get('id'),
            messages=messages
        )
    
    def to_dict(self) -> dict:
        return {
            'id': self.id,
            'messages': [msg.to_dict() for msg in self.messages]
        }
    
    def to_json(self) -> str:
        return json.dumps(self.to_dict())

    @classmethod
    def from_json(cls, json_str: str) -> 'Chat':
        data = json.loads(json_str)
        return cls.from_dict(data)
