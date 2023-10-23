import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exception.dart';
import '../../models/post.dart';
import '../remote/download_image.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getPosts();
  Future<void> cachePosts(List<PostModel> postsToCache);
}

const cachedPostsKey = 'CACHED_POSTS';

class PostLocalDataSourceImpl implements PostLocalDataSource {
  final GetImageRemoteDataSource getImage;
  final SharedPreferences plugin;

  PostLocalDataSourceImpl(this.plugin, this.getImage);

  @override
  Future<List<PostModel>> getPosts() async {
    final jsonString = plugin.getString(cachedPostsKey);
    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);
      List<PostModel> posts = [];
      for (var json in jsonList) {
        String pathPost =
            await getImage.downloadImage(json['image'], json['id']);
        String pathUser =
            await getImage.downloadImage(json['userImage'], json['userId']);
        json['image'] = pathPost;
        json['userImage'] = pathUser;
        posts.add(PostModel.fromJson(json));
      }
      return Future.value(posts);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cachePosts(List<PostModel> postsToCache) {
    List<dynamic> jsonList = [];
    for (var post in postsToCache) {
      jsonList.add(post.toJson());
    }
    return plugin.setString(cachedPostsKey, json.encode(jsonList));
  }
}
