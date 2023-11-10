from typing import List, Optional

from app.data.datasources.local.sketch import SketchLocalDataSourceImpl
from app.data.repositories.sketch import SketchRepositoryImpl
from app.domain.entities.sketch import Sketch
from app.domain.entities.user import User
from app.domain.repositories.sketch import BaseRepository as SketchRepository
from app.domain.use_cases.sketch.create import CreateSketch
from app.domain.use_cases.sketch.create import Params as CreateSketchChatParams
from app.domain.use_cases.sketch.delete import DeleteSketch
from app.domain.use_cases.sketch.delete import Params as DeleteSketchChatParams
from app.domain.use_cases.sketch.update import Params as UpdateSketchChatParams
from app.domain.use_cases.sketch.update import UpdateSketch
from app.domain.use_cases.sketch.view import Params as ViewSketchChatParams
from app.domain.use_cases.sketch.view import ViewSketch
from app.domain.use_cases.sketch.views import ListSketches
from app.domain.use_cases.sketch.views import Params as ViewsSketchChatParams
from core.common.current_user import get_current_user
from core.config.database_config import get_db
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm.session import Session


class SketchResponse(BaseModel):
    id: str
    title: Optional[str]

router = APIRouter()

def get_sketch_repository(db: Session = Depends(get_db)):
    sketch_local_datasource = SketchLocalDataSourceImpl(db=db)
    return SketchRepositoryImpl(sketch_local_datasource)

@router.post("/teams/{team_id}/sketches", response_model=SketchResponse)
async def create_sketch(
    sketch: Sketch,
    team_id: str,
    repository: SketchRepository = Depends(get_sketch_repository),
    current_user: User = Depends(get_current_user),
):
    sketch_chat_use_case = CreateSketch(repository)
    params = CreateSketchChatParams(sketch=sketch, team_id=team_id, user_id=current_user.id)
    result = await sketch_chat_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
    
@router.put("/teams/{team_id}/sketches/{sketch_id}", response_model=SketchResponse)
async def update_sketch(
    sketch: Sketch,
    team_id: str,
    sketch_id: str,
    repository: SketchRepository = Depends(get_sketch_repository),
    current_user: User = Depends(get_current_user),
):
    sketch_chat_use_case = UpdateSketch(repository)
    params = UpdateSketchChatParams(sketch=sketch, team_id=team_id, user_id=current_user.id, sketch_id=sketch_id)
    result = await sketch_chat_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
    
    
@router.delete("/sketches/{sketch_id}")
async def delete_sketch(
    sketch_id: str,
    repository: SketchRepository = Depends(get_sketch_repository),
    current_user: User = Depends(get_current_user),
):
    sketch_chat_use_case = DeleteSketch(repository)
    params = DeleteSketchChatParams(user_id=current_user.id, sketch_id=sketch_id)
    result = await sketch_chat_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)

@router.get("/sketches/{sketch_id}", response_model=SketchResponse)
async def view_sketch(
    sketch_id: str,
    repository: SketchRepository = Depends(get_sketch_repository),
    current_user: User = Depends(get_current_user),
):
    sketch_chat_use_case = ViewSketch(repository)
    params = ViewSketchChatParams(user_id=current_user.id, sketch_id=sketch_id)
    result = await sketch_chat_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)

@router.get("/teams/{team_id}/sketches", response_model=List[SketchResponse])
async def view_all_sketches(
    team_id: str,
    repository: SketchRepository = Depends(get_sketch_repository),
    current_user: User = Depends(get_current_user),
):
    sketch_chat_use_case = ListSketches(repository)
    params = ViewsSketchChatParams(user_id=current_user.id, team_id=team_id)
    result = await sketch_chat_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
    
    