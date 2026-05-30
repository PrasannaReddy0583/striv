import 'package:equatable/equatable.dart';

enum MessageStatus { sent, delivered, seen }

class ChatMessage extends Equatable {
  final String id;
  final String senderId;
  final String text;
  final String time;
  final bool isMe;
  final bool seen;
  final MessageStatus status;

  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    required this.time,
    required this.isMe,
    required this.seen,
    required this.status,
  });

  @override
  List<Object?> get props =>
      [id, senderId, text, time, isMe, seen, status];
}
