enum MessageStatus { sent, delivered, seen }

class Message {
  final String id;
  final String senderId;
  final String text;
  final String time;
  final bool isMe;
  bool seen;
  final MessageStatus status;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.time,
    this.isMe = false,
    this.seen = false,
    required this.status,
  });
}
