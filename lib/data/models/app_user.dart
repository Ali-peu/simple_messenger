import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String name;
  final String userEmail;
  final String uid;
  final bool isOnline;
  final DateTime lastActive;
  const AppUser({
    required this.lastActive,
    required this.name,
    required this.uid,
    required this.isOnline,
    required this.userEmail,
  });

  static AppUser fromJson(Map<String, dynamic> json) {
    return AppUser(
      name: json['name'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
      isOnline: json['isOnline'] as bool? ?? false,
      userEmail: json['userEmail'] as String? ?? '',
      lastActive: DateTime.now(),
      // lastActive: json['lastActive'] as DateTime? ?? DateTime.now()
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['uid'] = uid;
    data['isOnline'] = isOnline;
    data['userEmail'] = userEmail;
    data['lastActive'] = lastActive;

    return data;
  }

  @override
  List<Object?> get props => [name, uid, isOnline, userEmail, lastActive];
}
