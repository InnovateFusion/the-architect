from core.config.database_config import Base
from sqlalchemy import Column, String, ForeignKey, Table
from sqlalchemy.orm import relationship

class PostModel(Base):
    __tablename__ = 'posts'

    id = Column(String(36), primary_key=True, nullable=True)
    title = Column(String(128), nullable=False)
    content = Column(String(128), nullable=False)
    user_id = Column(String(36), ForeignKey('users.id'), nullable=False)
    user = relationship('UserModel', back_populates='posts')
    
    def __repr__(self):
        return f'<PostModel(id={self.id}, title={self.title})>'