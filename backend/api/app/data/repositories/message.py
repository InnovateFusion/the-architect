from app.domain.entities.message import Message, MessageEntity
from core.common.either import Either
from core.errors.failure import Failure, CacheFailure
from core.errors.exceptions import CacheException
from app.domain.repositories.message import BaseRepository
from app.data.datasources.local.message import MessageLocalDataSource

class MessageRepositoryImpl(BaseRepository):
        
    def __init__(self, message_local_datasource: MessageLocalDataSource):
        self.message_local_datasource = message_local_datasource
        
    async def create_message(self, message: Message, chat_id: str) -> Either[Failure, MessageEntity]:
        try:
            chat_entity = await self.message_local_datasource.create_chat(message, chat_id)
            return Either.right(chat_entity)
        except CacheException as e:
            return Either.left(CacheFailure(error_message=str(e)))
        

        