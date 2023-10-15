import 'dart:io';

import 'package:architect/core/errors/exception.dart';
import 'package:http/http.dart' show Client;
import 'package:path_provider/path_provider.dart';

abstract class GetImageRemoteDataSource {
  Future<String> downloadImage(String url, String id);
}

class GetImage implements GetImageRemoteDataSource {
  const GetImage({required this.client});

  final Client client;

  @override
  Future<String> downloadImage(String url, String id) async {
    final response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File file = File('${appDocDir.path}/$id.png');
      if (file.existsSync()) {
        await file.delete();
      }
      await file.writeAsBytes(response.bodyBytes);
      return file.path;
    } else {
      throw ServerException();
    }
  }
}
