import 'package:equatable/equatable.dart';

class ChatContact extends Equatable {
  final String id;
  final String name;
  final String avatar;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final bool isOnline;

  const ChatContact({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
  });

  @override
  List<Object?> get props =>
      [id, name, avatar, lastMessage, lastMessageTime, unreadCount, isOnline];
}
