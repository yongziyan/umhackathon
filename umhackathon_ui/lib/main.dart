import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const DietAssistantApp());
}

class DietAssistantApp extends StatelessWidget {
  const DietAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  // Use 10.0.2.2 for Android Emulator, localhost for Windows/Web
  final String apiUrl = "http://10.0.2.2:8080/api/workflow/chat?userId=user123";

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty) return;

    String userText = _controller.text;
    setState(() {
      _messages.add({"role": "user", "text": userText});
      _isLoading = true;
    });
    _controller.clear();

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "text/plain"},
        body: userText,
      );

      if (response.statusCode == 200) {
        setState(() {
          _messages.add({"role": "ai", "text": response.body});
        });
      } else {
        setState(() {
          _messages.add({"role": "ai", "text": "Error: Could not reach the brain."});
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"role": "ai", "text": "Check if your Spring Boot server is running on port 8080!"});
      });
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Z.AI Health Workflow"),
        centerTitle: true,
        backgroundColor: Colors.teal.shade50,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final m = _messages[index];
                bool isUser = m["role"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.teal : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      m["text"]!,
                      style: TextStyle(color: isUser ? Colors.white : Colors.black87),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) const LinearProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "What did you eat today?",
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}