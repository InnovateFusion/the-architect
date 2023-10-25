from typing import List
from uuid import uuid4
from datetime import datetime
import requests
from cloudinary.uploader import upload
from sqlalchemy.orm import Session
from abc import ABC, abstractmethod
from app.data.datasources.remote.ai import AiGeneration
from app.data.models.chat import ChatModel
from app.data.models.user import UserModel
from app.domain.entities.chat import ChatEntity, Notify
from app.domain.entities.message import Message, MessageEntity
from core.errors.exceptions import CacheException
import os
baseUrl = os.getenv("BASE_URL")

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
        
    @abstractmethod
    async def delete_chat(self, chat_id: str) -> ChatEntity:
        ...
        
    @abstractmethod
    async def notify(self, chat_id: str, notify_id: str, notify: Notify) -> ChatEntity:
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
        exits_user = self.db.query(UserModel).filter(UserModel.id == message.user_id).first()
        if not exits_user:
            raise CacheException("No user found")
        
        date = datetime.utcnow()
        
        if 'prompt' not in message.payload:
            raise CacheException("No prompt found")
        
        headers = {
            "accept": "application/json",
            "content-type": "application/json"
        }
        
        ai_generation = AiGeneration(requests, upload)
        response = ""
        userImage = ''
        chatResponse = ''
        analysis = {'title': '', 'detail': ''}
        threeD = { 'status': '', 'url': ''}
        aiMessageID = str(uuid4())
        chat_id = str(uuid4())
        
        if message.model == 'text_to_image':
            url = f"${baseUrl}/text-to-image"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
            except Exception as e:
                raise CacheException("Error getting image")
        elif message.model == 'image_to_image':
            url = f"${baseUrl}/image-to-image"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image")
        elif message.model == 'controlNet':
            url = f"${baseUrl}/controlnet"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image")
        elif message.model == 'painting':
            url = f"${baseUrl}/inpaint"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image")
        elif message.model == 'instruction':
            url = f"${baseUrl}/instruct"
            try:
                response = await ai_generation.get_image(url, headers, message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image")
        elif message.model == 'image_variant':
            try:
                response = await ai_generation.image_variant(message.payload)
                userImage = await ai_generation.upload_image(message.payload['image'])
            except:
                raise CacheException("Error getting image variant")
        elif message.model == 'image_from_text':
            try:
                response = await ai_generation.create_from_text(message.payload)
            except:
                raise CacheException("Error getting image from text")
        elif message.model == 'edit_image':
            try:
                response = await ai_generation.create_from_image(message.payload)
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
            except:
                raise CacheException("Analysis error")
        elif message.model == 'text_to_3D':
            try:
                threeD = await ai_generation.text_to_threeD(chat_id, aiMessageID, message.payload)
            except:
                raise CacheException("3D error from text")
        elif message.model == 'image_to_3D':
            try:
                threeD = await ai_generation.image_to_threeD(chat_id, aiMessageID, message.payload)
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
        
        chat = ChatModel(
            id=chat_id,
            user_id=message.user_id,
            messages=[message_from_user.to_json()],
            title = message.payload['prompt'][:128],
        )
        
        message_from_ai = MessageEntity(
            id=aiMessageID,
            content= {
                'prompt': '',
                'imageUser': '',
                'imageAI': response,
                'model': message.model,
                'analysis': analysis,
                '3D': threeD,
                'chat': chatResponse
            },
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
        
    async def delete_chat(self, chat_id: str) -> ChatEntity:
        existing_chat = self.db.query(ChatModel).filter(ChatModel.id == chat_id).first()
        if not existing_chat:
            raise CacheException("Chat does not exist")
        
        self.db.delete(existing_chat)
        self.db.commit()
        
        return ChatEntity(
            id=existing_chat.id,
            title=existing_chat.title,
            user_id=existing_chat.user_id,
            messages=existing_chat.messages 
        )
        
    async def notify(self, chat_id: str, notify_id: str, notify: Notify) -> ChatEntity:
        existing_chat = self.db.query(ChatModel).filter(ChatModel.id == chat_id).first()
        if not existing_chat:
            raise CacheException("Chat does not exist")
        print(notify, notify.payload)
        try:
            for message in existing_chat.messages:
                if message.id == notify_id:
                    message.content['3D']['status'] = notify.status
                    message.content['3D']['fetch_result'] = notify.output[0]
                    break            
        except Exception as e:
            print(e)
            raise CacheException("Error getting 3D")
        
        self.db.add(existing_chat)
        self.db.commit()
        
        return ChatEntity(
            id=existing_chat.id,
            title=existing_chat.title,
            user_id=existing_chat.user_id,
            messages=existing_chat.messages 
        )