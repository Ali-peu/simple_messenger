import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_messenger/blocs/chat_bloc/chat_bloc.dart';
import 'package:simple_messenger/data/models/app_user.dart';
import 'package:simple_messenger/data/models/chat_message.dart';
import 'package:simple_messenger/domain/utilts.dart';

class ChatCard extends StatelessWidget {
  final AppUser appUser;
  const ChatCard({required this.appUser, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: DecoratedBox(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  circleContainer(appUser),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Text(
                          appUser.name,
                          style: const TextStyle(fontSize: 15),
                        ),
                        StreamBuilder(
                            stream: context
                                .read<ChatBloc>()
                                .getLastMessage(appUser),
                            builder: (context, snapshot) {
                              final data = snapshot.data?.docs;
                              final list = data
                                      ?.map(
                                          (e) => ChatMessage.fromJson(e.data()))
                                      .toList() ??
                                  [];
                              if (list.isNotEmpty) {
                                final message = list[0];
                                return Text(message.message);
                              } else {
                                return const Text('......');
                              }
                            })
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(Utilts.getMesssageTime(appUser.lastActive))
                ]),
          ),
        );
      },
    );
  }
}

Widget circleContainer(AppUser appUser) {
  return Container(
    width: 34,
    height: 34,
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(0.25),
      shape: BoxShape.circle,
    ),
    child: Padding(
      padding: const EdgeInsets.all(2),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
        ),
        child: Center(child: Text(appUser.name.substring(1, 2))),
      ),
    ),
  );
}
