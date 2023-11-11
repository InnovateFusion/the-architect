import 'dart:convert';

import 'package:architect/features/architect/data/models/user.dart';
import 'package:http/http.dart' show Client;

import '../../../../../core/errors/exception.dart';
import '../../../domains/entities/team.dart';
import '../../../domains/entities/user.dart';
import '../../models/team.dart';

abstract class TeamRemoteDataSource {
  Future<Team> create({
    required String title,
    required String token,
    String? description,
    String? image,
    List<String>? members,
  });

  Future<Team> update({
    required String title,
    required String token,
    required String teamId,
    String? description,
    String? image,
    List<String>? members,
  });

  Future<List<Team>> views(String token);

  Future<Team> view(
    String id,
    String token,
  );
  Future<Team> delete(
    String id,
    String token,
  );
  Future<Team> join(String teamId, String userId, String token);
  Future<Team> leave(String teamId, String userId, String token);
  Future<Team> addUsers(List<String> usersId, String token, String teamId);
  Future<List<User>> teamMembers(
    String teamId,
    String token,
  );
}
String baseUrlArch = 'https://the-architect.onrender.com';

class TeamRemoteDataSourceImpl implements TeamRemoteDataSource {
  const TeamRemoteDataSourceImpl({required this.client});

  final Client client;

  @override
  Future<Team> addUsers(
      List<String> usersIds, String token, String teamId) async {
    final response = await client.post(
      Uri.parse('$baseUrlArch/api/v1/teams/$teamId/add-users'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'user_ids': usersIds,
        },
      ),
    );
    if (response.statusCode == 200) {
      final postsJson = json.decode(response.body);
      final TeamModel posts = TeamModel.fromJson(postsJson);
      return posts;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Team> create(
      {required String title,
      required String token,
      String? description,
      String? image,
      List<String>? members}) async {
    final response = await client.post(
      Uri.parse('$baseUrlArch/api/v1/teams/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'title': title,
          'description': description ?? '',
          'image': image ?? '',
          'user_ids': members ?? [],
        },
      ),
    );
    if (response.statusCode == 200) {
      final teamJson = json.decode(response.body);
      return TeamModel.fromJson(teamJson);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Team> delete(String id, String token) async {
    final response = await client
        .delete(Uri.parse('$baseUrlArch/api/v1/teams/$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final teamJson = json.decode(response.body);
      return TeamModel.fromJson(teamJson);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Team> join(String teamId, String userId, String token) async {
    final response = await client.get(
        Uri.parse('$baseUrlArch/api/v1/teams/$teamId/users/$userId/join'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      final teamJson = json.decode(response.body);
      return TeamModel.fromJson(teamJson);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Team> leave(String teamId, String userId, String token) async {
    final response = await client.get(
        Uri.parse('$baseUrlArch/api/v1/teams/$teamId/users/$userId/leave'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      final teamJson = json.decode(response.body);
      return TeamModel.fromJson(teamJson);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<User>> teamMembers(String teamId, String token) async {
    final response = await client.get(
        Uri.parse('$baseUrlArch/api/v1/teams/$teamId/members'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        });
    if (response.statusCode == 200) {
      return Future.value((json.decode(response.body) as List)
          .map((e) => UserModel.fromJson(e))
          .toList());
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Team> update({
    required String title,
    required String token,
    required String teamId,
    String? description,
    String? image,
    List<String>? members,
  }) async {
    final response = await client.put(
      Uri.parse('$baseUrlArch/api/v1/teams/$teamId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'title': title,
          'description': description ?? '',
          'image': image ?? '',
          'user_ids': members ?? [],
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final teamJson = json.decode(response.body);
      return TeamModel.fromJson(teamJson);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Team> view(String id, String token) async {
    final response = await client
        .get(Uri.parse('$baseUrlArch/api/v1/teams/$id'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      final teamJson = json.decode(response.body);
      return TeamModel.fromJson(teamJson);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Team>> views(String token) async {
    final response =
        await client.get(Uri.parse('$baseUrlArch/api/v1/teams/'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      return Future.value((json.decode(response.body) as List)
          .map((e) => TeamModel.fromJson(e))
          .toList());
    } else {
      throw ServerException();
    }
  }
}
