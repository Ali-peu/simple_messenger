import 'package:flutter/material.dart';
import 'package:simple_messenger/ui/widgets/chat_card.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({ super.key });

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чаты'),
        centerTitle: false
      ),
      body: SafeArea(child:
       ListView.builder(
        itemBuilder: (context,index){
          return const ChatCard();
        },
        itemCount: 4,
      )),

    );
  }
}