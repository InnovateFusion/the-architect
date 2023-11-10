from abc import ABC, abstractmethod
from uuid import uuid4

import requests
from app.data.datasources.remote.ai import AiGeneration
from app.domain.entities.free import Free, FreeEntity
from cloudinary.uploader import upload
from core.errors.exceptions import CacheException
from sqlalchemy.orm import Session


class FreeLocalDataSource(ABC):
    @abstractmethod
    async def free_chat(self, free: Free) -> FreeEntity:
        pass


class FreeLocalDataSourceImpl(FreeLocalDataSource):
    def __init__(self, db: Session):
        self.db = db

    async def free_chat(self, free: Free) -> FreeEntity:
        response = ""
        ai_generation = AiGeneration(requests, upload)
        try:
            response = await ai_generation.create_from_text({'prompt': free.prompt})
        except Exception as e:
            print(e)
            raise CacheException("Error getting image from text")
        
        return FreeEntity(
            id=str(uuid4()),
        prompt=free.prompt,
        image=response
        )