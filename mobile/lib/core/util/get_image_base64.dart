import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<String?> getImageAsBase64(String? imageUrl) async {
  if (imageUrl == null) return Future(() => null);
  try {
    final response = await http.get(Uri.parse(imageUrl));

    if (response.statusCode == 200) {
      final imageBytes = response.bodyBytes;
      final cacheDirectory = await getTemporaryDirectory();
      final uniqueFileName = DateTime.now().toString();
      final filePath = '${cacheDirectory.path}/$uniqueFileName.png';

      final file = File(filePath);
      await file.writeAsBytes(imageBytes);
      return filePath;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
