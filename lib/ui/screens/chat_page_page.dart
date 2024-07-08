import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_messenger/blocs/chat_bloc/chat_bloc.dart';
import 'package:simple_messenger/data/models/app_user.dart';
import 'package:simple_messenger/data/models/chat_message.dart';

class ChatPagePage extends StatefulWidget {
  final AppUser appUser;
  const ChatPagePage({required this.appUser, super.key});

  @override
  State<ChatPagePage> createState() => _ChatPagePageState();
}

class _ChatPagePageState extends State<ChatPagePage> {
  final TextEditingController textEditingController = TextEditingController();
  Widget messageBox(String message,
      {required Alignment alignment,
      Color color = const Color.fromRGBO(245, 245, 245, 1),
      bool myMessages = true}) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft:
                      myMessages ? const Radius.circular(10) : Radius.zero,
                  bottomRight:
                      !myMessages ? const Radius.circular(10) : Radius.zero,
                ),
                color: color),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(message),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: const BackButton(),
            title: Text(widget.appUser.name),
            centerTitle: false),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: context
                      .read<ChatBloc>()
                      .getFirebaseStream(widget.appUser),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const SizedBox();
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        final messsages = data
                            ?.map((message) =>
                                ChatMessage.fromJson(message.data()))
                            .toList();
                        return BlocBuilder<ChatBloc, ChatState>(
                          builder: (context, state) {
                            return ListView(
                              children: messsages!
                                  .map((message) => message.fromId ==
                                          context.read<ChatBloc>().getUserID()
                                      ? messageBox(message.message,
                                          alignment: Alignment.centerRight)
                                      : messageBox(message.message,
                                          alignment: Alignment.centerLeft,
                                          myMessages: false,
                                          color: Colors.green.shade100))
                                  .toList(),
                              reverse: true,
                            );
                          },
                        );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: textEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          hintText: 'Type Something...',
                          hintStyle: TextStyle(color: Colors.blueAccent),
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        if (textEditingController.text.isNotEmpty) {
                          context.read<ChatBloc>().add(SendMessage(
                              sendPerson: widget.appUser,
                              message: textEditingController.text));
                          textEditingController.clear();
                        }
                      },
                      icon: const Icon(Icons.send))
                ],
              ),
            )
          ],
        ));
  }
}
