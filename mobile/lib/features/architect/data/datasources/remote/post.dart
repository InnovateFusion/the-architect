import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../../../../../core/errors/exception.dart';
import '../../models/post.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> allPosts({
    String? search,
    List<String>? tags,
    required String token,
    int? skip,
    int? limit,
  });
  Future<List<PostModel>> viewsPost(String id, String token);
  Future<PostModel> createPost({
    required String image,
    required String title,
    String? content,
    required List<String> tags,
    required String userId,
    required String token,
  });

  Future<PostModel> editPost({
    required String image,
    required String title,
    String? content,
    required List<String> tags,
    required String id,
    required String userId,
    required String token,
  });

  Future<PostModel> deletePost(String id, String token);
  Future<PostModel> likePost(String id, String token);
  Future<PostModel> clonePost(String id, String token);
  Future<PostModel> unLikePost(String id, String token);
  Future<PostModel> viewPost(String id, String token);
}

String baseUrlArch = 'https://the-architect.onrender.com';

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  const PostRemoteDataSourceImpl({required this.client});

  final Client client;

  @override
  Future<List<PostModel>> allPosts({
    String? search,
    List<String>? tags,
    required String token,
    int? skip,
    int? limit,
  }) async {
    final queryParameters = <String, dynamic>{};

    if (search != null && search.isNotEmpty) {
      queryParameters['search_word'] = search.replaceAll(' ', '&');
    }

    if (tags != null && tags.isNotEmpty) {
      queryParameters['tags'] = tags.join('&tags=');
    }

    if (skip != null) {
      queryParameters['skip'] = skip.toString();
    } else {
      queryParameters['skip'] = '0';
    }

    if (limit != null) {
      queryParameters['limit'] = limit.toString();
    } else {
      queryParameters['limit'] = '8';
    }

    final url = Uri.parse('$baseUrlArch/api/v1/posts/all')
        .replace(queryParameters: queryParameters)
        .toString();

    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> postsJson = json.decode(response.body);
      final List<PostModel> posts =
          postsJson.map((post) => PostModel.fromJson(post)).toList();
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> viewsPost(String id, String token) async {
    final response = await client.get(
      Uri.parse('$baseUrlArch/api/v1/users/$id/posts'),
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

  @override
  Future<PostModel> clonePost(String id, String token) async {
    final response = await client.get(
      Uri.parse('$baseUrlArch/api/v1/posts/$id/clone'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final postsJson = json.decode(response.body);
      final PostModel posts = PostModel.fromJson(postsJson);
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> likePost(String id, String token) async {
    final response = await client.get(
      Uri.parse('$baseUrlArch/api/v1/posts/$id/like'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final postsJson = json.decode(response.body);
      final PostModel posts = PostModel.fromJson(postsJson);
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> unLikePost(String id, String token) async {
    final response = await client.get(
      Uri.parse('$baseUrlArch/api/v1/posts/$id/unlike'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final postsJson = json.decode(response.body);
      final PostModel posts = PostModel.fromJson(postsJson);
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> createPost(
      {required String image,
      required String title,
      String? content,
      required List<String> tags,
      required String userId,
      required String token}) async {
    final response = await client.post(
      Uri.parse('$baseUrlArch/api/v1/posts/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'image': image,
          'title': title,
          'content': content ?? '',
          'userId': userId,
          'tags': tags,
        },
      ),
    );
    if (response.statusCode == 200) {
      final postsJson = json.decode(response.body);
      final PostModel posts = PostModel.fromJson(postsJson);
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> deletePost(String id, String token) async {
    final response = await client.delete(
      Uri.parse('$baseUrlArch/api/v1/posts/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final postsJson = json.decode(response.body);
      final PostModel posts = PostModel.fromJson(postsJson);
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> editPost(
      {required String image,
      required String title,
      String? content,
      required List<String> tags,
      required String userId,
      required String id,
      required String token}) async {
    final response = await client.put(
      Uri.parse('$baseUrlArch/api/v1/posts/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'image': image,
          'title': title,
          'content': content ?? '',
          'userId': userId,
          'tags': tags,
        },
      ),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final postsJson = json.decode(response.body);
      final PostModel posts = PostModel.fromJson(postsJson);
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PostModel> viewPost(String id, String token) async {
    final response = await client.get(
      Uri.parse('$baseUrlArch/api/v1/posts/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final postsJson = json.decode(response.body);
      final PostModel posts = PostModel.fromJson(postsJson);
      return posts;
    } else {
      throw ServerException();
    }
  }
}
