part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}


class GoogleAuth extends AuthEvent{}

class SignOut extends AuthEvent{}