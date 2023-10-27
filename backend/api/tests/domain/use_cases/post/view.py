import unittest
from unittest.mock import MagicMock
from app.domain.entities.post import PostEntity
from app.domain.repositories.post import BaseRepository
from core.common.either import Either
from core.errors.failure import Failure
from app.domain.entities.post import AllPost, Params

class TestAllPost(unittest.IsolatedAsyncioTestCase):
    
    def setUp(self) -> None:
        self.repository = MagicMock(BaseRepository)
        self.use_case = AllPost(self.repository)
        
    async def test_all_post_success(self):
        tags = ['tag1', 'tag2']
        search_word = 'example'
        skip = 0
        limit = 10
        
        expected_post_entities = [
            PostEntity(id='post1', title='Post Title 1', content='Post Content 1', tags=tags),
            PostEntity(id='post2', title='Post Title 2', content='Post Content 2', tags=tags)
        ]
        
        params = Params(tags, search_word, skip, limit)
        
        self.repository.all_posts.return_value = Either.right(expected_post_entities)
        
        result = await self.use_case(params)
        
        self.assertTrue(result.is_right())
        self.assertEqual(list(result.get()), expected_post_entities)
        self.repository.all_posts.assert_called_once_with(tags, search_word, skip, limit)
        
    async def test_all_post_failure(self):
        tags = ['tag3', 'tag4']
        search_word = 'test'
        skip = 5
        limit = 20
        
        params = Params(tags, search_word, skip, limit)
        
        self.repository.all_posts.return_value = Either.left(Failure())
        
        result = await self.use_case(params)
        
        self.assertTrue(result.is_left())
        self.assertEqual(result.get(), Failure())
        self.repository.all_posts.assert_called_once_with(tags, search_word, skip, limit)

if __name__ == '__main__':
    unittest.main()
