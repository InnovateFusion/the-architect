from uuid import uuid4
from datetime import datetime
from sqlalchemy.orm import Session
from abc import ABC, abstractmethod
from app.data.datasources.remote.image import ImageGeneration
from app.data.models.chat import ChatModel
from app.domain.entities.message import Message, MessageEntity
from core.errors.exceptions import CacheException
import requests
from cloudinary.uploader import upload

class MessageLocalDataSource(ABC):
    @abstractmethod
    async def create_chat(self, message: Message, chat_id: str) -> MessageEntity:
        pass
    
class MessageLocalDataSourceImpl(MessageLocalDataSource):
    def __init__(self, db: Session):
        self.db = db
   
    async def create_chat(self, message: Message, chat_id: str) -> MessageEntity:
        date = datetime.utcnow()
        if 'prompt' not in message.payload:
            raise CacheException("No prompt found")

        headers = {
            "accept": "application/json",
            "content-type": "application/json"
        }
        
        image_generation = ImageGeneration(requests, upload)
        response = None
        
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
            
        message_from_user = MessageEntity(
            id=str(uuid4()),
            content=message.payload['prompt'],
            sender='user',
            date=date
        )
        
        existing_chat = self.db.query(ChatModel).filter(ChatModel.id == chat_id).first()
        if not existing_chat:
            raise CacheException("Chat does not exist")
        
        new_chat = [i for i in  existing_chat.messages]
        new_chat.append(message_from_user.to_json())
        
        message_from_ai = MessageEntity(
            id=str(uuid4()),
            content=response,
            sender='ai',
            date=date
        )
        
        new_chat.append(message_from_ai.to_json())
        
        existing_chat.messages = new_chat

        self.db.commit()
        
        return message_from_ai
    


