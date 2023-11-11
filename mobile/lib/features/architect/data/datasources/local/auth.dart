import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exception.dart';
import '../../models/auth.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(AuthModel token);
  Future<AuthModel> getToken();
  Future<AuthModel> isValid();
  Future<void> deleteToken();
}

const String authCacheKey = 'auth';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences plugin;

  AuthLocalDataSourceImpl(this.plugin);

  @override
  Future<void> cacheToken(AuthModel token) {
    return plugin.setString(authCacheKey, json.encode(token.toJson()));
  }

  @override
  Future<AuthModel> getToken() {
    final token = plugin.getString(authCacheKey);
    if (token != null) {
      Map<String, dynamic> jsonMap = json.decode(token);
      return Future.value(AuthModel.fromJson(jsonMap));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<AuthModel> isValid() async {
    return await getToken();
  }

  @override
  Future<void> deleteToken() {
    return plugin.remove(authCacheKey);
  }
}
