import unittest
from unittest.mock import MagicMock
from app.domain.entities.user import UserEntity
from app.domain.repositories.user import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.use_cases.user.view import ViewUser, Params

class TestViewUser(unittest.IsolatedAsyncioTestCase):
    
    def setUp(self) -> None:
        self.repository = MagicMock(BaseRepository)
        self.use_case = ViewUser(self.repository)
        
    async def test_view_user_success(self):
        user_id = 'user123'  # Replace with a valid user ID
        expected_user_entity = UserEntity(
            id=user_id,
            username='user123',
            email='user@example.com'
        )
        params = Params(user_id)
        
        self.repository.view_user.return_value = Either.right(expected_user_entity)
        
        result = await self.use_case(params)
        self.assertTrue(result.is_right())
        self.assertEqual(result.get(), expected_user_entity)
        self.repository.view_user.assert_called_once_with(user_id)
        
    async def test_view_user_failure(self):
        user_id = 'user456'  # Replace with a valid user ID
        params = Params(user_id)
        self.repository.view_user.return_value = Either.left(Failure())
        
        result = await self.use_case(params)
        self.assertTrue(result.is_left())
        self.assertEqual(result.get(), Failure())
        self.repository.view_user.assert_called_once_with(user_id)

if __name__ == '__main__':
    unittest.main()
