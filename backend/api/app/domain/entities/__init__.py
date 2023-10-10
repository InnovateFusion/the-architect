from abc import ABCMeta, abstractmethod
from typing import Optional
from pydantic.dataclasses import dataclass
from core.common.equatable import Equatable

@dataclass
class BaseEntity(Equatable, metaclass=ABCMeta):
    id: Optional[str]

    @classmethod
    @abstractmethod
    def from_dict(cls, other: dict) -> object:
        ...
        
    @abstractmethod
    def to_dict(self) -> dict:
        ...