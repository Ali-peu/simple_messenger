import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_messenger/blocs/chat_bloc/chat_bloc.dart';
import 'package:simple_messenger/data/models/app_user.dart';
import 'package:simple_messenger/ui/screens/chat_page_page.dart';
import 'package:simple_messenger/ui/widgets/chat_card.dart';

class ChatsListPage extends StatefulWidget {
  const ChatsListPage({super.key});

  @override
  State<ChatsListPage> createState() => _ChatsListPageState();
}

class _ChatsListPageState extends State<ChatsListPage> {
  final textController = TextEditingController();
  final textController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чаты'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () => context.read<ChatBloc>().add(SignOut()),
              child: const Text('SignOut'))
        ],
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return SafeArea(
              child: StreamBuilder(
                  stream: context.read<ChatBloc>().getMyUsersId(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null &&
                        snapshot.data!.docs.isNotEmpty) {
                      return StreamBuilder(
                          stream: context.read<ChatBloc>().getAllUsers(
                              snapshot.data?.docs.map((e) => e.id).toList() ??
                                  []),
                          builder: (context, usersSnapshot) {
                            if (usersSnapshot.connectionState ==
                                ConnectionState.active) {
                              final data = usersSnapshot.data?.docs;
                              final list = data
                                      ?.map((e) => AppUser.fromJson(e.data()))
                                      .toList() ??
                                  [];

                              log(list.toString(), name: 'trog: ');
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChatPagePage(
                                                      appUser: list[index]))),
                                      child: ChatCard(appUser: list[index]));
                                },
                                itemCount: list.length,
                              );
                            } else {
                              log(usersSnapshot.toString(), name: 'Users :');
                              return const Center(
                                  child: Text('connection state'));
                            }
                          });
                    } else {
                      return const Center(child: Text('userId'));
                    }
                  }));
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) {
                return Column(
                  children: [
                    TextField(controller: textController),
                    GestureDetector(
                      onTap: () => context
                          .read<ChatBloc>()
                          .add(AddUserForChat(email: textController.text)),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(child: Text('Send')),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
