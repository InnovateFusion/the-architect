from datetime import datetime
from fastapi import HTTPException, APIRouter, Depends
from typing import Optional, Dict
from app.data.datasources.local.message import MessageLocalDataSourceImpl
from app.domain.entities.message import Message
from app.domain.entities.user import User
from app.domain.repositories.message import BaseRepository as MessageRepository
from app.data.repositories.message import MessageRepositoryImpl
from app.domain.use_cases.message.create import CreateMessage, Params as CreateMessageParams
from core.common.current_user import get_current_user
from core.config.database_config import get_db
from sqlalchemy.orm.session import Session
from pydantic import BaseModel

class MessageResponse(BaseModel):
    id: Optional[str]
    sender: str
    content: Dict
    date: datetime
    
router = APIRouter()

def get_repository(db: Session = Depends(get_db)):
    message_local_datasource = MessageLocalDataSourceImpl(db=db)
    return MessageRepositoryImpl(message_local_datasource)

@router.post("/chats/{chat_id}/messages", response_model=MessageResponse)
async def create_chat(
    chat_id: str,
    message: Message,
    repository: MessageRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    create_message_use_case = CreateMessage(repository)
    params = CreateMessageParams(message=message, chat_id=chat_id, user_id=current_user.id)
    result = await create_message_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
