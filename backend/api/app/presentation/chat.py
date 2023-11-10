from typing import List, Optional

from app.data.datasources.local.chat import ChatLocalDataSourceImpl
from app.data.repositories.chat import ChatRepositoryImpl
from app.domain.entities.message import Message
from app.domain.entities.user import User
from app.domain.repositories.chat import BaseRepository as ChatRepository
from app.domain.use_cases.chat.create import CreateChat
from app.domain.use_cases.chat.create import Params as CreateChatParams
from app.domain.use_cases.chat.delete import DeleteChat
from app.domain.use_cases.chat.delete import Params as DeleteChatParams
from app.domain.use_cases.chat.view import Params as ViewChatParams
from app.domain.use_cases.chat.view import ViewChat
from app.domain.use_cases.chat.views import Params as ViewChatsParams
from app.domain.use_cases.chat.views import ViewChats
from core.common.current_user import get_current_user
from core.config.database_config import get_db
from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm.session import Session


class ChatResponse(BaseModel):
    id: Optional[str]
    user_id: str
    title: str
    messages: List[str]


router = APIRouter()

def get_repository(db: Session = Depends(get_db)):
    chat_local_datasource = ChatLocalDataSourceImpl(db=db)
    return ChatRepositoryImpl(chat_local_datasource)

@router.post("/chats/", response_model=ChatResponse)
async def create_chat(
    message: Message,
    repository: ChatRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    create_chat_use_case = CreateChat(repository)
    params = CreateChatParams(message=message)
    result = await create_chat_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
    
@router.get("/users/{user_id}/chats/", response_model=List[ChatResponse])
async def view_chats(
    user_id: str,
    repository: ChatRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    view_chats_use_case = ViewChats(repository)
    params = ViewChatsParams(user_id=user_id)
    result = await view_chats_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)


@router.get("/chats/{chat_id}", response_model=ChatResponse)
async def view_chat(
    chat_id: str,
    repository: ChatRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    view_chat_use_case = ViewChat(repository)
    params = ViewChatParams(chat_id=chat_id)
    result = await view_chat_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
    
@router.delete("/chats/{chat_id}", response_model=ChatResponse)
async def delete_chat(
    chat_id: str,
    repository: ChatRepository = Depends(get_repository),
    current_user: User = Depends(get_current_user)
):
    delete_chat_use_case = DeleteChat(repository)
    params = DeleteChatParams(chat_id=chat_id)
    result = await delete_chat_use_case(params)
    if result.is_right():
        return result.get()
    else:
        raise HTTPException(status_code=400, detail=result.get().error_message)
    
