import 'package:http/http.dart' as http;

class ApiService {
  // Use 10.0.2.2 if testing on Android Emulator. 
  // Use http://localhost:8080/api/workflow/chat if testing on iOS simulator or Chrome.
  static const String baseUrl = 'http://10.0.2.2:8080/api/workflow/chat';

  Future<String> askAgent(String userId, String userInput) async {
    try {
      final Uri url = Uri.parse('$baseUrl?userId=$userId');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'text/plain'},
        body: userInput,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return "Error: Backend returned status ${response.statusCode}";
      }
    } catch (e) {
      return "Network Error: Make sure your Spring Boot server is running! Details: $e";
    }
  }
}