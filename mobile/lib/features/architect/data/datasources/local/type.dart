import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exception.dart';
import '../../models/type.dart';

abstract class TypeLocalDataSource {
  Future<TypeModel> getType();
  Future<TypeModel> cacheTypes(String model);
}

const cachedTypesKey = 'CACHED_TYPES';

class TypeLocalDataSourceImpl implements TypeLocalDataSource {
  final SharedPreferences plugin;

  TypeLocalDataSourceImpl(this.plugin);

  @override
  Future<TypeModel> getType() async {
    final jsonString = plugin.getString(cachedTypesKey);
    if (jsonString != null) {
      return Future.value(TypeModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<TypeModel> cacheTypes(String model) {
    final typeModel = TypeModel(name: model);
    plugin.setString(
      cachedTypesKey,
      json.encode(typeModel.toJson()),
    );
    return Future.value(typeModel);
  }
}
