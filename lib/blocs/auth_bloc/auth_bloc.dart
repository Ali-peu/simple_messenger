import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:simple_messenger/domain/firebase_api.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required FirebaseApi firebaseApi})
      : _firebaseApi = firebaseApi,
        super(const AuthState()) {

          on<SignOut>((event, emit) async {
            await _firebaseApi.signOut();
          });
    on<GoogleAuth>((event, emit) async {
      emit(state.copyWith(authStatus: AuthStatus.loading));

      try {
        final response = await _firebaseApi.googleSign();
        if (response) {
          emit(state.copyWith(authStatus: AuthStatus.success));
        }else
        {
          emit(state.copyWith(authStatus: AuthStatus.failure));
        }
      } on Exception catch (error) {
        print(error.toString());
        emit(state.copyWith(authStatus: AuthStatus.failure));
      }
    });
  }

  final FirebaseApi _firebaseApi;

  void print(String print) {
    if (kDebugMode) {
      debugPrint(print);
    }
  }
}
