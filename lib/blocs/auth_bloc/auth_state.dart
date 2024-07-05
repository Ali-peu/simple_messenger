part of 'auth_bloc.dart';

enum AuthStatus{success, failure, initial, loading}
class AuthState extends Equatable {
  final AuthStatus authStatus;

   const AuthState({this.authStatus = AuthStatus.initial});

   AuthState copyWith({AuthStatus? authStatus}){
    return AuthState(
      authStatus:  authStatus ?? this.authStatus
    );
  }
  @override
  List<Object?> get props => [authStatus];
}
