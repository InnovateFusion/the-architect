from datetime import datetime

from core.config.database_config import Base
from sqlalchemy import Column, DateTime, ForeignKey, String
from sqlalchemy.orm import relationship


class SketchModel(Base):
     __tablename__ = 'sketches'
     id = Column(String(36), primary_key=True, nullable=False)
     name = Column(String(256), nullable=False)
     team_id = Column(String(36), ForeignKey('teams.id'), nullable=False)
     team = relationship('TeamModel', back_populates='sketches')
     
     def __repr__(self) -> str:
         return f'<SketchModel id={self.id} name={self.name} team_id={self.team_id}>'
     
class TeamModel(Base):
    __tablename__ = 'teams'
    id = Column(String(36), primary_key=True, nullable=False)
    creator_id = Column(String(36), ForeignKey('users.id'), nullable=False)
    title = Column(String(512), nullable=False)
    description = Column(String(1024))
    image = Column(String(512))
    date = Column(DateTime, default=datetime.utcnow)
    sketches = relationship('SketchModel', back_populates='team')
    members = relationship('UserTeamModel', back_populates='team')
    
    
    def teamMembers(self):
        return self.members

    def __repr__(self) -> str:
        return f'<TeamModel id={self.id} title={self.title}>'


class UserTeamModel(Base):
    __tablename__ = 'user_team'

    id = Column(String(36), primary_key=True, nullable=True)
    user_id = Column(String(36), ForeignKey('users.id'), nullable=False)
    team_id = Column(String(36), ForeignKey('teams.id'), nullable=False)
    user = relationship('UserModel', back_populates='teams')
    team = relationship('TeamModel', back_populates='members')

    def __repr__(self):
        return f'<UserTeamModel(id={self.id})>'
