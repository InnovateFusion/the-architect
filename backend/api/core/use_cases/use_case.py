from dataclasses import dataclass
from typing import Type, TypeVar, Generic
from abc import ABC, abstractmethod
from core.common.either import Either
from core.common.equatable import Equatable
from core.errors.failure import Failure

Type = TypeVar('Type')

class UseCase(ABC, Generic[Type]):
    @abstractmethod
    def __call__(self, params: Type) -> Either[Failure, Type]:
        pass
    
@dataclass
class NoParams(Equatable):
    pass