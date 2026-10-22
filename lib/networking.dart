import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkBrain {
  NetworkBrain(this.url);

  final String url;

  Future<dynamic> getData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception(
      'Weather API failed: ${response.statusCode} ${response.body}',
    );
  }
}

