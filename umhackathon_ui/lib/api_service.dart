import 'package:http/http.dart' as http;

class ApiService {
  // 10.0.2.2 is the 'localhost' for Android Emulators
  static const String baseUrl = 'http://10.0.2.2:8080/api/workflow/chat';

  Future<String> sendToAI(String message) async {
    final response = await http.post(
      Uri.parse('$baseUrl?userId=user123'),
      body: message,
      headers: {"Content-Type": "text/plain"},
    );
    return response.body;
  }
}