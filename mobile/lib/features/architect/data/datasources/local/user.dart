import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exception.dart';
import '../../models/user.dart';
import '../remote/download_image.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getUsers();
  Future<void> cacheUser(UserModel userToCache);
}

const cachedUserKey = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences plugin;
  final GetImageRemoteDataSource getImage;

  UserLocalDataSourceImpl(this.plugin, this.getImage);

  @override
  Future<UserModel> getUsers() async {
    final jsonString = plugin.getString(cachedUserKey);
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return Future.value(UserModel.fromJson(jsonMap));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(UserModel userToCache) async {
    final jsonMap = userToCache.toJson();

    String pathUser =
        await getImage.downloadImage(jsonMap['image'], jsonMap['id']);
    jsonMap['image'] = pathUser;

    plugin.setString(cachedUserKey, json.encode(jsonMap));
    return Future.value();
  }
}
