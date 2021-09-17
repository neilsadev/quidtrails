import 'dart:typed_data';

import 'package:http/http.dart' as http;

class Network {
  Future<Uint8List> loadNetworkImage(Uri? imageUrl) async {
    try {
      final response = await http.get(imageUrl!);
      return response.bodyBytes;
    } catch (_) {
      throw "Couldn't resolve network Image.";
    }
  }
}
