import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../../../../../core/errors/exception.dart';
import '../../models/user.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> viewUser(String id, String token);
  Future<UserModel> meUser(String token);
  Future<UserModel> createUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? image,
    String? bio,
    String? country,
  });

  Future<UserModel> updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String token,
    String? image,
    String? bio,
    String? country,
  });
  Future<UserModel> deleteUser(String id, String token);
  Future<UserModel> followUser(String id, String token);
  Future<UserModel> unfollowUser(String id, String token);
  Future<List<UserModel>> followersUser(String id, String token);
  Future<List<UserModel>> followingUser(String id, String token);
  Future<List<UserModel>> viewsAll(String token);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final Client client;

  UserRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> createUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? image,
    String? bio,
    String? country,
  }) async {
    final response = await client.post(
      Uri.parse('https://the-architect.onrender.com/api/v1/users/'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'image': image ?? '',
        'bio': bio ?? '',
        'country': country ?? '',
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String token,
    String? image,
    String? bio,
    String? country,
  }) async {
    final response = await client.put(
      Uri.parse('https://the-architect.onrender.com/api/v1/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'image': image ?? '',
        'bio': bio ?? '',
        'country': country ?? '',
      }),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> deleteUser(String id, String token) async {
    final response = await client.delete(
      Uri.parse('https://the-architect.onrender.com/api/v1/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> followUser(String id, String token) async {
    final response = await client.get(
      Uri.parse('https://the-architect.onrender.com/api/v1/users/$id/follow/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> followersUser(String id, String token) async {
    final response = await client.get(
      Uri.parse(
          'https://the-architect.onrender.com/api/v1/users/$id/followers'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Future.value((json.decode(response.body) as List)
          .map((e) => UserModel.fromJson(e))
          .toList());
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> followingUser(String id, String token) async {
    final response = await client.get(
      Uri.parse(
          'https://the-architect.onrender.com/api/v1/users/$id/following'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Future.value((json.decode(response.body) as List)
          .map((e) => UserModel.fromJson(e))
          .toList());
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> unfollowUser(String id, String token) async {
    final response = await client.delete(
      Uri.parse(
          'https://the-architect.onrender.com/api/v1/users/$id/unfollow/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> viewUser(String id, String token) async {
    final response = await client.get(
      Uri.parse('https://the-architect.onrender.com/api/v1/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> meUser(String token) async {
    final response = await client.get(
      Uri.parse('https://the-architect.onrender.com/api/v1/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<UserModel>> viewsAll(String token) async {
    final response = await client.get(
      Uri.parse('https://the-architect.onrender.com/api/v1/users'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Future.value((json.decode(response.body) as List)
          .map((e) => UserModel.fromJson(e))
          .toList());
    } else {
      throw ServerException();
    }
  }
}
