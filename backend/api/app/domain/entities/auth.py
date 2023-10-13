import json
from dataclasses import dataclass
from app.domain.entities.message import Message
from app.domain.entities import BaseEntity

class Auth(dict):
    email: str
    password: str

@dataclass
class AuthEntity(BaseEntity):
    access_token: str
    token_type: str

    
    @classmethod
    def from_dict(cls, data: dict) -> 'AuthEntity':
        return cls(
            access_token=data['access_token'],
            token_type=data['token_type']
        )
    
    def to_dict(self) -> dict:
        return {
            'token_type': self.token_type,
            'access_token': self.access_token
        }
    
    def to_json(self) -> str:
        return json.dumps(self.to_dict())

    @classmethod
    def from_json(cls, json_str: str) -> 'AuthEntity':
        data = json.loads(json_str)
        return cls.from_dict(data)
