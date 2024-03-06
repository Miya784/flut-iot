import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final String url = 'https://node-emqx.burhan.cloud/auth/signin';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      final data = jsonDecode(response.body);
      return data;
    } catch (error) {
      throw Exception('Failed to login: $error');
    }
  }
}
