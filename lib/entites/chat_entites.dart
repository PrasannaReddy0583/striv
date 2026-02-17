// lib/features/chat/domain/entities/chat.dart
class ChatEntites {
  final String chatRoomId; // chat ID (could be userId or roomId)
  final String name; // user / startup name
  final String avatar; // profile picture URL
  final String lastMessage; // preview of last message
  final String time; // last message time (formatted string for now)
  final int unreadCount; // number of unread messages
  final DateTime lastSeen; // last seen timestamp
  // pinned / priority chats

  ChatEntites({
    required this.chatRoomId,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    required this.lastSeen,
  });
}
