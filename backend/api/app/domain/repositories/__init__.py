from abc import ABC

class ContextManagerRepository(ABC):

    def __enter__(self):
        return self

    def __exit__(self, *args, **kwargs) -> None:
        self.commit()