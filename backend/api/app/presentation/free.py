from typing import Optional

from app.data.datasources.local.free import FreeLocalDataSourceImpl
from app.data.repositories.free import FreeRepositoryImpl
from app.domain.entities.free import Free
from app.domain.repositories.free import BaseRepository as FreeRepository
from app.domain.use_cases.free.chat import FreeChat
from app.domain.use_cases.free.chat import Params as FreeChatParams
from core.config.database_config import get_db
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm.session import Session


class FreeResponse(BaseModel):
    prompt: Optional[str]
    image: Optional[str]
    
router = APIRouter()

def get_repository(db: Session = Depends(get_db)):
    message_local_datasource = FreeLocalDataSourceImpl(db=db)
    return FreeRepositoryImpl(message_local_datasource)

@router.post("/free", response_model=FreeResponse)
async def create_chat(
    free: Free,
    repository: FreeRepository = Depends(get_repository)
):
    free_chat_use_case = FreeChat(repository)
    params = FreeChatParams(free=free)
    result = await free_chat_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
    

