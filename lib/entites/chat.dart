class Chat {
  final String id;
  final String name;
  String lastMessage;
  String lastMessageTime;
  final String avatar;
  int unread;
  bool isOnline;

  Chat({
    required this.id,
    required this.name,
    required this.avatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unread,
    required this.isOnline,
  });
}
