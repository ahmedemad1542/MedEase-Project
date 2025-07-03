import 'package:flutter/material.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Soon!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold, // يجب أن يكون داخل TextStyle
          ),
        ),
      ),
    );
  }
}
