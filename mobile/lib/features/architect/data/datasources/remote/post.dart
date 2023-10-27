import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../../../../../core/errors/exception.dart';
import '../../models/post.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> allPosts(
      String? search, List<String>? tags, String token);
  Future<List<PostModel>> viewsPost(String id, String token);
  // Future<PostModel> createPost(PostModel post, String token);
  // Future<PostModel> updatePost(PostModel post, String token);
  // Future<PostModel> deletePost(String id, String token);
  // Future<PostModel> likePost(String id, String token);
  // Future<PostModel> clonePost(String id, String token);
  // Future<PostModel> unLikePost(String id, String token);
  // Future<PostModel> unClonePost(String id, String token);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  const PostRemoteDataSourceImpl({required this.client});

  final Client client;

  @override
  Future<List<PostModel>> allPosts(
      String? search, List<String>? tags, String token) async {
    final response = await client.get(
      Uri.parse('https://the-architect.onrender.com/api/v1/posts/all'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
<<<<<<< HEAD
=======
      print(json.decode(response.body));
>>>>>>> ccf8b2c (:boom: add new feature)
      final List<dynamic> postsJson = json.decode(response.body);
      final List<PostModel> posts = [];
      for (final post in postsJson) {
        posts.add(PostModel.fromJson(post));
      }
<<<<<<< HEAD

=======
>>>>>>> ccf8b2c (:boom: add new feature)
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> viewsPost(String id, String token) async {
    final response = await client.get(
      Uri.parse('https://the-architect.onrender.com/api/v1/users/$id/posts'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> postsJson = json.decode(response.body);
      final List<PostModel> posts = [];
      for (final post in postsJson) {
        posts.add(PostModel.fromJson(post));
      }
      return posts;
    } else {
      throw ServerException();
    }
  }
}
