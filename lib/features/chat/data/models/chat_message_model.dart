import 'package:striv/features/chat/domain/entities/chat_message.dart';

class ChatMessageModel extends ChatMessage {
  const ChatMessageModel({
    required super.id,
    required super.senderId,
    required super.text,
    required super.time,
    required super.isMe,
    required super.seen,
    required super.status,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      text: json['text'] as String,
      time: json['time'] as String,
      isMe: json['isMe'] as bool? ?? false,
      seen: json['seen'] as bool? ?? false,
      status: MessageStatus.values.firstWhere(
        (s) => s.name == (json['status'] as String? ?? 'sent'),
        orElse: () => MessageStatus.sent,
      ),
    );
  }
}
