import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:testing_demo/services/api_client.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('ApiClient Tests', () {
    late ApiClient apiClient;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      apiClient = ApiClient(client: mockClient);
    });

    test('fetchUser returns user data when successful', () async {
      // Arrange
      const String responseJson = '''
        {
          "id": 1,
          "name": "John Doe",
          "email": "john@example.com"
        }
      ''';

      when(() => mockClient.get(any()))
          .thenAnswer((_) async => http.Response(responseJson, 200));

      // Act
      final Map<String, dynamic> user = await apiClient.fetchUser(1);

      // Assert
      expect(user['id'], equals(1));
      expect(user['name'], equals('John Doe'));
      expect(user['email'], equals('john@example.com'));
      verify(() => mockClient.get(Uri.parse('https://jsonplaceholder.typicode.com/users/1'))).called(1);
    });

    test('fetchUser throws exception when request fails', () async {
      // Arrange
      when(() => mockClient.get(any()))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act & Assert
      expect(() => apiClient.fetchUser(1), throwsA(isA<Exception>()));
    });

    test('fetchPosts returns list of posts when successful', () async {
      // Arrange
      const String responseJson = '''
        [
          {"id": 1, "title": "Post 1", "body": "Content 1"},
          {"id": 2, "title": "Post 2", "body": "Content 2"}
        ]
      ''';

      when(() => mockClient.get(any()))
          .thenAnswer((_) async => http.Response(responseJson, 200));

      // Act
      final List<Map<String, dynamic>> posts = await apiClient.fetchPosts();

      // Assert
      expect(posts, isA<List<Map<String, dynamic>>>());
      expect(posts.length, equals(2));
      expect(posts[0]['title'], equals('Post 1'));
    });
  });
}