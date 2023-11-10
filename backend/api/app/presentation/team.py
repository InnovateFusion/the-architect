from datetime import datetime
from typing import Optional

from app.data.datasources.local.team import TeamLocalDataSourceImpl
from app.data.repositories.team import TeamRepositoryImpl
from app.domain.entities.team import Team
from app.domain.entities.user import User
from app.domain.repositories.team import BaseRepository as TeamRepository
from app.domain.use_cases.team.add_member import AddTeamMember
from app.domain.use_cases.team.add_member import Params as AddTeamMemberParams
from app.domain.use_cases.team.create import CreateTeam
from app.domain.use_cases.team.create import Params as CreateTeamParams
from app.domain.use_cases.team.delete import DeleteTeam
from app.domain.use_cases.team.delete import Params as DeleteTeamParams
from app.domain.use_cases.team.join import JoinTeam
from app.domain.use_cases.team.join import Params as JoinTeamParams
from app.domain.use_cases.team.leave import LeaveTeam
from app.domain.use_cases.team.leave import Params as LeaveTeamParams
from app.domain.use_cases.team.members import Params as TeamMembersParams
from app.domain.use_cases.team.members import TeamMembers
from app.domain.use_cases.team.update import Params as UpdateTeamParams
from app.domain.use_cases.team.update import UpdateTeam
from app.domain.use_cases.team.view import Params as ViewTeamParams
from app.domain.use_cases.team.view import ViewTeam
from app.domain.use_cases.team.views import Params as ViewTeamsParams
from app.domain.use_cases.team.views import ViewTeams
from app.presentation.user import UserResponse
from core.common.current_user import get_current_user
from core.config.database_config import get_db
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm.session import Session


class TeamResponse(BaseModel):
    id: Optional[str]
    title: str
    description: Optional[str]
    creator_id: Optional[str]
    first_name: Optional[str]
    last_name: Optional[str]
    creator_image: Optional[str]
    image: Optional[str]
    create_at: datetime

    class Config:
        arbitrary_types_allowed = True

class TeamRequest(BaseModel):
    user_ids: Optional[list[str]]

    class Config:
        arbitrary_types_allowed = True

def get_repository(db: Session = Depends(get_db)):
    team_local_datasource = TeamLocalDataSourceImpl(db=db)
    return TeamRepositoryImpl(team_local_datasource)


router = APIRouter()


@router.post("/teams/", response_model=TeamResponse)
async def create_team(
    team: Team,
    repository: TeamRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user),
):
    create_team_use_case = CreateTeam(repository)
    params = CreateTeamParams(team=team, user_id=current_user.id, user_ids=team.user_ids or [])
    result = await create_team_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/teams/", response_model=list[TeamResponse])
async def view_teams(
    repository: TeamRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user),
):
    view_teams_use_case = ViewTeams(repository)
    params = ViewTeamsParams(user_id=current_user.id)
    result = await view_teams_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.put("/teams/{team_id}", response_model=TeamResponse)
async def update_team(
    team_id: str,
    team: Team,
    repository: TeamRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user),
):
    update_team_use_case = UpdateTeam(repository)
    params = UpdateTeamParams(
        team=team, team_id=team_id, user_id=current_user.id)
    result = await update_team_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.delete("/teams/{team_id}", response_model=TeamResponse)
async def delete_team(
    team_id: str,
    repository: TeamRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user),
):
    delete_team_use_case = DeleteTeam(repository)
    params = DeleteTeamParams(team_id=team_id)
    result = await delete_team_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/teams/{team_id}/users/{user_id}/leave", response_model=TeamResponse)
async def leave_team(
    team_id: str,
    user_id: str,
    repository: TeamRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user),
):
    leave_team_use_case = LeaveTeam(repository)
    params = LeaveTeamParams(team_id=team_id, user_id=user_id)
    result = await leave_team_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/teams/{team_id}/users/{user_id}/join", response_model=TeamResponse)
async def join_team(
    team_id: str,
    user_id: str,
    repository: TeamRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user),
):
    join_team_use_case = JoinTeam(repository)
    params = JoinTeamParams(team_id=team_id, user_id=user_id)
    result = await join_team_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/teams/{team_id}", response_model=TeamResponse)
async def view_team(
    team_id: str,
    repository: TeamRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user),
):
    view_team_use_case = ViewTeam(repository)
    params = ViewTeamParams(team_id=team_id)
    result = await view_team_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/teams/{team_id}/members", response_model=list[UserResponse])
async def team_members(
    team_id: str,
    repository: TeamRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user),
):
    team_members_use_case = TeamMembers(repository)
    params = TeamMembersParams(team_id=team_id)
    result = await team_members_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)



@router.post("/teams/{team_id}/add-users/", response_model=TeamResponse)
async def add_team_member(
    team_id: str,
    users: TeamRequest,
    repository: TeamRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user),
):
    add_team_member_use_case = AddTeamMember(repository)
    params = AddTeamMemberParams(team_id=team_id, creator_id=current_user.id, user_ids=users.user_ids)
    result = await add_team_member_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
