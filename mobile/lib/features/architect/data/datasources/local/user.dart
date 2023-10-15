import 'dart:convert';

import 'package:architect/features/architect/data/datasources/remote/download_image.dart';
import 'package:architect/features/architect/data/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exception.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getUser();
  Future<void> cacheUser(UserModel userToCache);
}

const cachedUserKey = 'CACHED_USER';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences plugin;
  final GetImage getImage;

  UserLocalDataSourceImpl(this.plugin, this.getImage);

  @override
  Future<UserModel> getUser() async {
    final jsonString = plugin.getString(cachedUserKey);
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      String pathUser =
          await getImage.downloadImage(jsonMap['image'], jsonMap['id']);
      jsonMap['image'] = pathUser;
      return Future.value(UserModel.fromJson(jsonMap));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheUser(UserModel userToCache) {
    return plugin.setString(cachedUserKey, json.encode(userToCache.toJson()));
  }
}
