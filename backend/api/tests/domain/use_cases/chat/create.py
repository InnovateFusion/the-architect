import unittest
from unittest.mock import MagicMock
from app.domain.entities.chat import ChatEntity
from app.domain.entities.message import Message
from app.domain.repositories.chat import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.chat import CreateChat, Params

class TestCreateChat(unittest.IsolatedAsyncioTestCase):
    
    def setUp(self) -> None:
        self.repository = MagicMock(BaseRepository)
        self.use_case = CreateChat(self.repository)
        
    async def test_create_chat_success(self):
        message = Message(
            sender='User1',
            content='Hello, this is a test message',
            timestamp='2023-10-27 12:00:00'
        )
        
        expected_chat_entity = ChatEntity(id='chat1', name='Chat 1', members=['User1', 'User2'])
        params = Params(message)
        
    
        self.repository.create_chat.return_value = Either.right(expected_chat_entity)
        
 
        result = await self.use_case(params)
        

        self.assertTrue(result.is_right())
        self.assertEqual(result.get(), expected_chat_entity)
        self.repository.create_chat.assert_called_once_with(message)
        
    async def test_create_chat_failure(self):

        message = Message(
            sender='User2',
            content='This is a different test message',
            timestamp='2023-10-27 14:00:00'
        )
        
        params = Params(message)
        
        self.repository.create_chat.return_value = Either.left(Failure())
        
        result = await self.use_case(params)

        self.assertTrue(result.is_left())
        self.assertEqual(result.get(), Failure())
        self.repository.create_chat.assert_called_once_with(message)

if __name__ == '__main__':
    unittest.main()
