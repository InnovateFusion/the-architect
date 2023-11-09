from typing import List

from app.data.datasources.local.chat import ChatLocalDataSource
from app.domain.entities.chat import ChatEntity, Notify
from app.domain.entities.message import Message
from app.domain.repositories.chat import BaseRepository
from core.common.either import Either
from core.errors.exceptions import CacheException
from core.errors.failure import CacheFailure, Failure


class ChatRepositoryImpl(BaseRepository):
        
    def __init__(self, chat_local_datasource: ChatLocalDataSource):
        self.chat_local_datasource = chat_local_datasource
        
    async def create_chat(self, message: Message) -> Either[Failure, ChatEntity]:
        try:
            chat_entity = await self.chat_local_datasource.create_chat(message)
            return Either.right(chat_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
        
    async def view_chats(self, user_id) -> Either[Failure, List[ChatEntity]]:
        try:
            chats = await self.chat_local_datasource.get_chats(user_id)
            return Either.right(chats)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
        
    async def view_chat(self, chat_id: str) -> Either[Failure, ChatEntity]:
        try:
            chat_entity = await self.chat_local_datasource.get_chat(chat_id)
            return Either.right(chat_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
    
    async def delete_chat(self, chat_id: str) -> Either[Failure, ChatEntity]:
        try:
            chat_entity = await self.chat_local_datasource.delete_chat(chat_id)
            return Either.right(chat_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
        
