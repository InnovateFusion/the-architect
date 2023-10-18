from typing import List
from uuid import uuid4
from datetime import datetime
import requests
from cloudinary.uploader import upload
from sqlalchemy.orm import Session
from abc import ABC, abstractmethod
from app.data.datasources.remote.image import ImageGeneration
from app.data.models.chat import ChatModel
from app.data.models.user import UserModel
from app.domain.entities.chat import ChatEntity
from app.domain.entities.message import Message, MessageEntity
from core.errors.exceptions import CacheException

class ChatLocalDataSource(ABC):
    @abstractmethod
    async def get_chat(self, chat_id: str) -> ChatEntity:
        ...
    
    @abstractmethod
    async def get_chats(self, user_id) -> List[ChatEntity]:
        ...
    
    @abstractmethod
    async def create_chat(self, message: Message):
        ...
    
class ChatLocalDataSourceImpl(ChatLocalDataSource):
    def __init__(self, db: Session):
        self.db = db
        
    async def get_chat(self, chat_id: str) -> ChatEntity:
        existing_chat = self.db.query(ChatModel).filter(ChatModel.id == chat_id).first()
        if not existing_chat:
            raise CacheException("Chat does not exist")

        return ChatEntity(
            id=existing_chat.id,
            title=existing_chat.title,
            user_id=existing_chat.user_id,
            messages=existing_chat.messages 
        )
    
    async def get_chats(self, user_id: str) -> List[ChatEntity]:
        existing_chats = self.db.query(ChatModel).filter(UserModel.id == user_id).all()

        if not existing_chats:
            raise CacheException("No chats found")

        filtered_chats = [
            ChatEntity(
                id=chat.id,
                title=chat.title,
                user_id=chat.user_id,
                messages=chat.messages
            ) for chat in existing_chats
        ]

        return filtered_chats

    async def create_chat(self, message: Message):
        date = datetime.utcnow()
        
        if 'prompt' not in message.payload:
            raise CacheException("No prompt found")
            
        message_from_user = MessageEntity(
            id=str(uuid4()),
            content=message.payload['prompt'],
            sender='user',
            date=date
        )
        
        headers = {
            "accept": "application/json",
            "content-type": "application/json"
        }
        
        image_generation = ImageGeneration(requests, upload)
        response = "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
        
        if message.model == 'text_to_image':
            url = "https://api.getimg.ai/v1/stable-diffusion/text-to-image"
            try:
                response = await image_generation.get_image(url, headers, message.payload)
            except Exception as e:
                raise CacheException("Error getting image")
        elif message.model == 'image_to_image':
            url = "https://api.getimg.ai/v1/stable-diffusion/image-to-image"
            try:
                response = await image_generation.get_image(url, headers, message.payload)
            except:
                raise CacheException("Error getting image")
        elif message.model == 'controlNet':
            url = "https://api.getimg.ai/v1/stable-diffusion/controlnet"
            try:
                response = await image_generation.get_image(url, headers, message.payload)
            except:
                raise CacheException("Error getting image")
        elif message.model == 'painting':
            url = "https://api.getimg.ai/v1/stable-diffusion/inpaint"
            try:
                response = await image_generation.get_image(url, headers, message.payload)
            except:
                raise CacheException("Error getting image")
        elif message.model == 'instruction':
            url = "https://api.getimg.ai/v1/stable-diffusion/instruct"
            try:
                response = await image_generation.get_image(url, headers, message.payload)
            except:
                raise CacheException("Error getting image")
        
        exits_user = self.db.query(UserModel).filter(UserModel.id == message.user_id).first()
        
        if not exits_user:
            raise CacheException("No user found")
        
        chat = ChatModel(
            id=str(uuid4()),
            user_id=message.user_id,
            messages=[message_from_user.to_json()],
            title = message.payload['prompt'][:128],
        )
        
        message_from_ai = MessageEntity(
            id=str(uuid4()),
            content=response,
            sender='ai',
            date=date
        )
        
        
        chat.add_message(message_from_ai.to_json())
        
        self.db.add(chat)
        self.db.commit()
        
        return ChatEntity(
            id=chat.id,
            user_id=message.user_id,
            title=chat.title,
            messages=chat.messages
        )
        
    