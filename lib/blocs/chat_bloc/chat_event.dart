part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class AddUserForChat extends ChatEvent {
  final String email;
  AddUserForChat({required this.email});
}
class SignOut extends ChatEvent{}


class SendMessage extends ChatEvent{
  final String message;
  final AppUser sendPerson;

  SendMessage({required this.message, required this.sendPerson});

}