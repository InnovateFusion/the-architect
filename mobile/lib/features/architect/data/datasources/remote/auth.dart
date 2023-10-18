import 'dart:convert';
import 'package:architect/core/errors/exception.dart';
import 'package:architect/features/architect/data/models/auth.dart';
import 'package:http/http.dart' show Client;

abstract class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Client client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse('https://the-architect.onrender.com/api/v1/token/'),
      headers: {
        'content-Type': 'application/json',
        'accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return AuthModel.fromJson(json);
    } else {
      throw ServerException();
    }
  }
}
