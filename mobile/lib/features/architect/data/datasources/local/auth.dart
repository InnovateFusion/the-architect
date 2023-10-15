import 'dart:convert';
import 'package:architect/core/errors/exception.dart';
import 'package:architect/features/architect/data/models/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<AuthModel> getToken();
}

const String authCacheKey = 'auth';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences plugin;

  AuthLocalDataSourceImpl(this.plugin);

  @override
  Future<void> cacheToken(String token) {
    return plugin.setString(authCacheKey, token);
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
}
