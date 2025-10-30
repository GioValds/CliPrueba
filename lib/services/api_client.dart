import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final http.Client client;
  final String baseUrl;

  ApiClient(
      {required this.client,
      this.baseUrl = 'https://jsonplaceholder.typicode.com'});

  Future<Map<String, dynamic>> fetchUser(int userId) async {
    final response = await client.get(Uri.parse('$baseUrl/users/$userId'));

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load user: ${response.statusCode}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    final response = await client.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }
}
