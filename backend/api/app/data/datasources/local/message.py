from uuid import uuid4
from datetime import datetime
from sqlalchemy.orm import Session
from abc import ABC, abstractmethod
from app.data.datasources.remote.ai import AiGeneration
from app.data.models.chat import ChatModel
from app.domain.entities.message import Message, MessageEntity
from core.errors.exceptions import CacheException
import requests
from cloudinary.uploader import upload
import os
baseUrl = os.getenv("BASE_URL")

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
        
        existing_chat = self.db.query(ChatModel).filter(ChatModel.id == chat_id).first()
        if not existing_chat:
            raise CacheException("Chat does not exist")
        
        ai_generation = AiGeneration(requests, upload)
        response = ""
        userImage = ''
        chatResponse = ''
        analysis = {'title': '', 'detail': ''}
        threeD = ''
        aiMessageID = str(uuid4())
        
        if message.model == 'text_to_image':
            url = f"{baseUrl}/text-to-image"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
            except:
                raise CacheException("Error getting image")
        elif message.model == 'image_to_image':
            url = f"{baseUrl}/image-to-image"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image")
        elif message.model == 'controlNet':
            url = f"{baseUrl}/controlnet"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image")
        elif message.model == 'painting':
            url = f"{baseUrl}/inpaint"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image")
        elif message.model == 'instruction':
            url = f"{baseUrl}/instruct"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image")
        elif message.model == 'image_variant':
            try:
                response = await ai_generation.image_variant(message.payload)
            except:
                raise CacheException("Error getting image from variant")
        elif message.model == 'image_from_text':
            try:
                response = await ai_generation.create_from_text(message.payload)
            except:
                raise CacheException("Error getting image from text")
        elif message.model == 'edit_image':
            try:
                response = await ai_generation.image_variant(message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image edit")
        elif message.model == 'chatbot':
            try:
                chatResponse = await ai_generation.chatbot(message.payload)
            except:
                raise CacheException("Chatbot error")
        elif message.model == 'analysis':
            try:
                analysis = await ai_generation.analysis(message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Analysis error")
        elif message.model == 'text_to_3D':
            try:
                threeD = await ai_generation.text_to_threeD(message.payload)
            except Exception as e:
                print("The error ---------------------- ", e)
                raise CacheException("3D error from text")
        elif message.model == 'image_to_3D':
            try:
                threeD = await ai_generation.image_to_threeD(message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("3D error")
        else:
            raise CacheException("Model not found")
                
        message_from_user = MessageEntity(
            id=str(uuid4()),
            content= {
                'prompt': message.payload['prompt'],
                'imageUser': userImage,
                'imageAI': '',
                'model': message.model,
                'analysis': {},
                '3D': {},
                'chat': ''
            },
            sender='user',
            date=date
        )
        
        new_chat = [i for i in  existing_chat.messages]
        new_chat.append(message_from_user.to_json())
        
        message_from_ai = MessageEntity(
            id=aiMessageID,
            content= {
                'prompt': '',
                'imageUser': '',
                'imageAI': response,
                'model': message.model,
                'analysis': analysis,
                '3D':  { 'status': 'success', 'fetch_result': threeD},
                'chat': chatResponse
            },
            sender='ai',
            date=date
        )  
        new_chat.append(message_from_ai.to_json())
        
        existing_chat.messages = new_chat

        self.db.commit()
        
        return message_from_ai
