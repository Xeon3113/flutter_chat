import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/chat_screen.dart';

void main() => runApp(CoreWebChat());

class CoreWebChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Coreweb chat app', home: ChatScreen(),);
  }
}