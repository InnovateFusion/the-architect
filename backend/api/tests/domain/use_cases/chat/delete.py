import unittest
from unittest.mock import MagicMock
from app.domain.entities.chat import ChatEntity
from app.domain.repositories.chat import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.chat import DeleteChat, Params

class TestDeleteChat(unittest.IsolatedAsyncioTestCase):
    
    def setUp(self) -> None:
        self.repository = MagicMock(BaseRepository)
        self.use_case = DeleteChat(self.repository)
        
    async def test_delete_chat_success(self):
        chat_id = 'chat123'  # Replace with a valid chat ID
        expected_chat_entity = ChatEntity(id=chat_id, name='Chat Name', members=['User1', 'User2'])
        params = Params(chat_id)
        
        self.repository.delete_chat.return_value = Either.right(expected_chat_entity)
        
        result = await self.use_case(params)
        self.assertTrue(result.is_right())
        self.assertEqual(result.get(), expected_chat_entity)
        self.repository.delete_chat.assert_called_once_with(chat_id)
        
    async def test_delete_chat_failure(self):
        chat_id = 'chat456'  # Replace with a valid chat ID
        params = Params(chat_id)
        self.repository.delete_chat.return_value = Either.left(Failure())
        
        result = await self.use_case(params)
        self.assertTrue(result.is_left())
        self.assertEqual(result.get(), Failure())
        self.repository.delete_chat.assert_called_once_with(chat_id)

if __name__ == '__main__':
    unittest.main()
