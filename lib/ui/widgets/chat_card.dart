import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            circleContainer(),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                children: [
                  Text('Person name'),
                  Text(
                    'Last message',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            Spacer(),
            const Text('time text 15:45')
          ]),
    );
  }
}

Widget circleContainer() {
  return Container(
    width: 28,
    height: 28,
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
        child: Container(),
      ),
    ),
  );
}
