import 'dart:convert';

import 'package:architect/core/errors/exception.dart';
import 'package:http/http.dart' show Client;

import '../../models/sketch.dart';

abstract class RemoteSketchDataSource {
  Future<SketchModel> create({
    required String title,
    required String teamId,
    required String token,
  });

  Future<SketchModel> update({
    required String sketchId,
    required String title,
    required String teamId,
    required String token,
  });

  Future<List<SketchModel>> views({
    required String teamId,
    required String token,
  });
  Future<SketchModel> view(String sketchId, String token);

  Future<SketchModel> delete({
    required String sketchId,
    required String token,
  });
}

class RemoteSketchDataSourceImpl implements RemoteSketchDataSource {
  final Client client;

  RemoteSketchDataSourceImpl({required this.client});

  @override
  Future<SketchModel> create({
    required String title,
    required String teamId,
    required String token,
  }) async {
    final response = await client.post(
      Uri.parse(
          'https://the-architect.onrender.com/api/v1/teams/$teamId/sketches'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      return SketchModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SketchModel> update({
    required String sketchId,
    required String title,
    required String teamId,
    required String token,
  }) async {
    final response = await client.put(
      Uri.parse(
          'https://the-architect.onrender.com/api/v1/teams/$teamId/sketches/$sketchId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
      }),
    );

    if (response.statusCode == 200) {
      return SketchModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SketchModel>> views({
    required String teamId,
    required String token,
  }) async {
    final response = await client.get(
      Uri.parse(
          'https://the-architect.onrender.com/api/v1/teams/$teamId/sketches'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final sketches = jsonDecode(response.body) as List;
      return sketches.map((sketch) => SketchModel.fromJson(sketch)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SketchModel> view(String sketchId, String token) async {
    final response = await client.get(
      Uri.parse('https://the-architect.onrender.com/api/v1/sketches/$sketchId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return SketchModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SketchModel> delete({
    required String sketchId,
    required String token,
  }) async {
    final response = await client.delete(
      Uri.parse('https://the-architect.onrender.com/api/v1/sketches/$sketchId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return SketchModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
