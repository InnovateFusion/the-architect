class Equatable:
    def __eq__(self, other):
        if not isinstance(other, type(self)):
            return False
        return self.properties == other.properties