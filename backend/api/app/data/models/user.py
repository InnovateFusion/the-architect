from core.config.database_config import Base
from sqlalchemy import Column, ForeignKey, String, Table, func
from sqlalchemy.orm import relationship


class UserModel(Base):
    __tablename__ = 'users'

    id = Column(String(36), primary_key=True, nullable=True)
    first_name = Column(String(128), nullable=False)
    last_name = Column(String(128), nullable=False)
    bio = Column(String(128), nullable=True)
    image = Column(String(512), nullable=True)
    email = Column(String(128), nullable=False, unique=True)
    password = Column(String(128), nullable=False)
    country = Column(String(512), nullable=True)
    posts = relationship('PostModel', back_populates='user', lazy=True)
    likes = relationship('LikeModel', back_populates='user')
    clones = relationship('CloneModel', back_populates='user')
    chats = relationship('ChatModel', back_populates='user')
    teams = relationship('UserTeamModel', back_populates='user')

    following = relationship(
        'UserModel',
        secondary='user_following',
        primaryjoin='UserModel.id==user_following.c.follower_id',
        secondaryjoin='UserModel.id==user_following.c.following_id',
        backref='followers'
    )

    def get_followers_count(self, session):
        return session.query(func.count(user_following.c.follower_id)).filter(
            user_following.c.following_id == self.id
        ).scalar()

    def get_following_count(self, session):
        return session.query(func.count(user_following.c.following_id)).filter(
            user_following.c.follower_id == self.id
        ).scalar()

    def __repr__(self):
        return f'<UserModel(id={self.id}, email={self.email})>'


user_following = Table('user_following', Base.metadata,
                       Column('follower_id', String(36), ForeignKey(
                           'users.id'), primary_key=True),
                       Column('following_id', String(36), ForeignKey(
                           'users.id'), primary_key=True)
                       )
