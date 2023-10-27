import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:path_provider/path_provider.dart';

import '../../../../../core/errors/exception.dart';

abstract class GetImageRemoteDataSource {
  Future<String> downloadImage(String url, String id);
}

class GetImageRemoteDataSourceImpl implements GetImageRemoteDataSource {
  const GetImageRemoteDataSourceImpl({required this.client});

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
