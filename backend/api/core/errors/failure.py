from core.common.equatable import Equatable

class Failure(Equatable):
    def __init__(self, properties=None, error_message=None):
        self.properties = properties or []
        self.error_message = error_message

class ServerFailure(Failure):
    def __init__(self, error_message=None):
        super().__init__(error_message=error_message)

class CacheFailure(Failure):
    def __init__(self, error_message=None):
        super().__init__(error_message=error_message)
