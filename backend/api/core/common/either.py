from dataclasses import dataclass
from typing import TypeVar, Generic


TLeft = TypeVar('TLeft')
TRight = TypeVar('TRight')

class Either(Generic[TLeft, TRight]):
    def __init__(self, left: TLeft = None, right: TRight = None):
        self.left = left
        self.right = right

    @classmethod
    def left(cls, value: TLeft) -> 'Either':
        return cls(left=value)

    @classmethod
    def right(cls, value: TRight) -> 'Either':
        return cls(right=value)

    def is_left(self) -> bool:
        return self.left is not None

    def is_right(self) -> bool:
        return self.right is not None
    
    def get(self) ->  'Either':
        if self.is_right():
            return self.right
        return self.left