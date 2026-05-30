import 'package:striv/features/chat/domain/entities/chat_contact.dart';

class ChatContactModel extends ChatContact {
  const ChatContactModel({
    required super.id,
    required super.name,
    required super.avatar,
    required super.lastMessage,
    required super.lastMessageTime,
    required super.unreadCount,
    required super.isOnline,
  });

  factory ChatContactModel.fromJson(Map<String, dynamic> json) {
    return ChatContactModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String? ?? '',
      lastMessage: json['lastMessage'] as String? ?? '',
      lastMessageTime: json['lastMessageTime'] as String? ?? '',
      unreadCount: json['unreadCount'] as int? ?? 0,
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }
}
