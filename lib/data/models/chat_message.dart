import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String message;
  final String toId;
  final String fromId;
  final String read;
  final String sent;

  const ChatMessage({
    required this.message,
    required this.toId,
    required this.fromId,
    required this.read,
    required this.sent,
  });

  static ChatMessage fromJson(Map<String, dynamic> json) {
    return ChatMessage(
        message: json['message'] as String? ?? '',
        toId: json['toId'] as String? ?? '',
        fromId: json['fromId'] as String? ?? '',
        sent: json['sent'] as String? ?? '',
        read: json['read'] as String? ??'');
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['toId'] = toId;
    data['fromId'] = fromId;
    data['read'] = read;
    data['sent'] = sent;
    return data;
  }

  @override
  List<Object?> get props => [message,read,sent,toId,fromId];
}
