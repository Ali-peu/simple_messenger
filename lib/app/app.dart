import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_messenger/blocs/auth_bloc/auth_bloc.dart';
import 'package:simple_messenger/blocs/chat_bloc/chat_bloc.dart';
import 'package:simple_messenger/domain/firebase_api.dart';
import 'package:simple_messenger/ui/screens/auth_screen.dart';
import 'package:simple_messenger/ui/screens/chats_list_page.dart';

class App extends StatelessWidget {
  final FirebaseApi firebaseApi;
  const App({required this.firebaseApi, super.key});

  @override
  Widget build(BuildContext context) {
    final check = firebaseApi.checkUser();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(firebaseApi: firebaseApi),
        ),
        BlocProvider<ChatBloc>(
          create: (context) => ChatBloc(firebaseApi: firebaseApi),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: check ? const ChatsListPage() : const AuthScreen(),
      ),
    );
  }
}
