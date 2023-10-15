import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:architect/features/architect/data/models/post.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> allPosts(String? search, List<String>? tags);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  const PostRemoteDataSourceImpl({required this.client, required});

  final Client client;

  @override
  Future<List<PostModel>> allPosts(String? search, List<String>? tags) async {
    final response = await client.get(
      Uri.parse('https://the-architect.onrender.com/api/v1/posts/all'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<PostModel> posts = [];
      List<Map<String, dynamic>> jsonList = json.decode(response.body);
      for (var post in jsonList) {
        posts.add(PostModel.fromJson(post));
      }
      return posts;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
