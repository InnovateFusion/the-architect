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
      final auth = await getToken();
      final token = auth.accessToken;
      final Map<String, dynamic> decodedMap = json
          .decode(String.fromCharCodes(base64Url.decode(token.split('.')[1])));
      int expTimestamp = decodedMap['exp'];
      int currentTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      if (expTimestamp > currentTimestamp) {
        return auth;
      } else {
        throw CacheException();
      }
  }

  @override
  Future<void> deleteToken() {
    return plugin.remove(authCacheKey);
  }
}
