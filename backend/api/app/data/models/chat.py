from core.config.database_config import Base
from sqlalchemy import Column, String, JSON, ForeignKey
from sqlalchemy.orm import relationship

class ChatModel(Base):
    __tablename__ = 'chats'
    id = Column(String(36), nullable=True, primary_key=True)
    user_id = user_id = Column(String(36), ForeignKey('users.id'), nullable=False)
    title = Column(String(512), nullable=False)
    user = relationship('UserModel', back_populates='chats')
    messages = Column(JSON)
    
    def __repr__(self) -> str:
        return f'<ChatModel id={self.id} user_id={self.user_id} title={self.title}>'
    
    def add_message(self, message_dict):
        self.messages.append(message_dict)
