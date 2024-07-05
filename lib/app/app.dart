import 'package:flutter/material.dart';
import 'package:simple_messenger/ui/screens/chats_list_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatsListPage(),
    );
  }
}
