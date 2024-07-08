import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_messenger/blocs/auth_bloc/auth_bloc.dart';
import 'package:simple_messenger/ui/screens/chats_list_page.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.authStatus == AuthStatus.success) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ChatsListPage()));
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Messenger',
                    style: Theme.of(context).textTheme.titleLarge),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () => context.read<AuthBloc>().add(GoogleAuth()),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.red)),
                        child: Center(
                            child: Text('Google',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium))),
                  ),
                ),
                if (kDebugMode)
                  TextButton(
                      onPressed: () => context.read<AuthBloc>().add(SignOut()),
                      child: Center(child: Text('SignOut')))
              ],
            );
          },
        ),
      ),
    );
  }
}
