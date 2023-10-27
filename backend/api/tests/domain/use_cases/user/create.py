import unittest
from unittest.mock import MagicMock
from app.domain.entities.user import UserEntity
from app.domain.repositories.user import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.use_cases.user.create import CreateUser, Params, User

class TestCreateUser(unittest.IsolatedAsyncioTestCase):
    
    def setUp(self) -> None:
        self.repository = MagicMock(BaseRepository)
        self.use_case = CreateUser(self.repository)
        
    async def test_create_user_success(self):
        user = User(
            id='user1',
            username='user123',
            email='user@example.com',
            password='password123'
        )
        user_entity = UserEntity(
            id=user.id,
            username=user.username,
            email=user.email
        )
        params = Params(user)
        
        self.repository.create_user.return_value = Either.right(user_entity)
        
        result = await self.use_case(params)
        self.assertTrue(result.is_right())
        self.assertEqual(result.get(), user_entity)
        self.repository.create_user.assert_called_once_with(user)
        
    async def test_create_user_failure(self):
        user = User(
            id='user2',
            username='user456',
            email='anotheruser@example.com',
            password='password456'
        )
        params = Params(user)
        
        self.repository.create_user.return_value = Either.left(Failure())
        
        result = await self.use_case(params)
        self.assertTrue(result.is_left())
        self.assertEqual(result.get(), Failure())
        self.repository.create_user.assert_called_once_with(user)

if __name__ == '__main__':
    unittest.main()
