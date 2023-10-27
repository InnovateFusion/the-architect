import unittest
from unittest.mock import MagicMock
from app.domain.entities.post import PostEntity
from app.domain.repositories.post import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.post import CreatePost, Params

class TestCreatePost(unittest.IsolatedAsyncioTestCase):
    
    def setUp(self) -> None:
        self.repository = MagicMock(BaseRepository)
        self.use_case = CreatePost(self.repository)
        
    async def test_create_post_success(self):
        post_entity = PostEntity(
            id='post1',
            title='Post Title 1',
            content='Post Content 1',
            tags=['tag1', 'tag2']
        )
        params = Params(post_entity)
        
        self.repository.create_post.return_value = Either.right(post_entity)
        
        result = await self.use_case(params)
        self.assertTrue(result.is_right())
        self.assertEqual(result.get(), post_entity)
        self.repository.create_post.assert_called_once_with(post_entity)
        
    async def test_create_post_failure(self):
        post_entity = PostEntity(
            id='post2',
            title='Post Title 2',
            content='Post Content 2',
            tags=['tag3', 'tag4']
        )
        params = Params(post_entity)
        
        self.repository.create_post.return_value = Either.left(Failure())
        
        result = await self.use_case(params)
        self.assertTrue(result.is_left())
        self.assertEqual(result.get(), Failure())
        self.repository.create_post.assert_called_once_with(post_entity)

if __name__ == '__main__':
    unittest.main()
