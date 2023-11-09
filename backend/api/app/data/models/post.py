from datetime import datetime

from core.config.database_config import Base
from sqlalchemy import JSON, Column, DateTime, ForeignKey, String, func
from sqlalchemy.orm import relationship


class PostModel(Base):
    __tablename__ = 'posts'

    id = Column(String(36), primary_key=True, nullable=True)
    title = Column(String(512), nullable=False)
    content = Column(String(512), nullable=True)
    image = Column(String(128), nullable=True)
    user_id = Column(String(36), ForeignKey('users.id'), nullable=False)
    tags = Column(JSON, nullable=True)
    date = Column(DateTime, default=datetime.utcnow)
    user = relationship('UserModel', back_populates='posts')
    likes = relationship('LikeModel', back_populates='post')
    clones = relationship('CloneModel', back_populates='post')

    def is_liked(self, db, user_id):
        return db.query(LikeModel).filter(LikeModel.post_id == self.id, LikeModel.user_id == user_id).first() is not None

    def is_cloned(self, db, user_id):
        return db.query(CloneModel).filter(CloneModel.post_id == self.id, CloneModel.user_id == user_id).first() is not None

    def get_likes_count(self, db):
        return db.query(func.count(LikeModel.post_id)).filter(
            LikeModel.post_id == self.id
        ).scalar()

    def get_clones_count(self, db):
        return db.query(func.count(CloneModel.post_id)).filter(
            CloneModel.post_id == self.id
        ).scalar()

    def __repr__(self):
        return f'<PostModel(id={self.id}, title={self.title})>'


class LikeModel(Base):
    __tablename__ = 'likes'

    id = Column(String(36), primary_key=True, nullable=True)
    user_id = Column(String(36), ForeignKey('users.id'), nullable=False)
    post_id = Column(String(36), ForeignKey('posts.id'), nullable=False)
    user = relationship('UserModel', back_populates='likes')
    post = relationship('PostModel', back_populates='likes')

    def __repr__(self):
        return f'<LikeModel(id={self.id})>'


class CloneModel(Base):
    __tablename__ = 'clones'

    id = Column(String(36), primary_key=True, nullable=True)
    user_id = Column(String(36), ForeignKey('users.id'), nullable=False)
    post_id = Column(String(36), ForeignKey('posts.id'), nullable=False)
    user = relationship('UserModel', back_populates='clones')
    post = relationship('PostModel', back_populates='clones')

    def __repr__(self):
        return f'<CloneModel(id={self.id})>'
