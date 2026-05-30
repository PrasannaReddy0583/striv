import 'package:striv/features/chat/data/models/chat_contact_model.dart';
import 'package:striv/features/chat/data/models/chat_message_model.dart';
import 'package:striv/features/chat/domain/entities/chat_message.dart';

abstract class ChatLocalDataSource {
  Future<List<ChatContactModel>> getContacts();
  Future<List<ChatMessageModel>> getMessages(String contactId);
}

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  static const Map<String, List<Map<String, dynamic>>> _messagesData = {
    '1': [
      {'id': 'm1', 'senderId': '1', 'text': 'Hey Alice, how are you?', 'time': '9:30 AM', 'isMe': true, 'seen': true, 'status': 'seen'},
      {'id': 'm2', 'senderId': '1', 'text': 'Doing great! You?', 'time': '9:32 AM', 'isMe': false, 'seen': true, 'status': 'seen'},
      {'id': 'm3', 'senderId': 'me', 'text': 'All good. Let\'s meet soon.', 'time': '9:40 AM', 'isMe': true, 'seen': false, 'status': 'seen'},
    ],
    '2': [
      {'id': 'm1', 'senderId': '2', 'text': 'How\'s the project going?', 'time': 'Yesterday', 'isMe': false, 'seen': true, 'status': 'seen'},
      {'id': 'm2', 'senderId': 'me', 'text': 'Almost done 🚀', 'time': 'Yesterday', 'isMe': true, 'seen': true, 'status': 'seen'},
    ],
    '3': [
      {'id': 'm1', 'senderId': 'me', 'text': 'Hey Charlie, free today?', 'time': 'Mon', 'isMe': true, 'seen': true, 'status': 'seen'},
      {'id': 'm2', 'senderId': '3', 'text': 'Not really, busy day 😅', 'time': 'Mon', 'isMe': false, 'seen': false, 'status': 'seen'},
    ],
    '4': [
      {'id': 'm1', 'senderId': '4', 'text': 'Did you review the doc?', 'time': 'Sun', 'isMe': false, 'seen': true, 'status': 'seen'},
      {'id': 'm2', 'senderId': 'me', 'text': 'Yes, looks good 👍', 'time': 'Sun', 'isMe': true, 'seen': true, 'status': 'seen'},
    ],
    '5': [
      {'id': 'm1', 'senderId': 'me', 'text': 'Mission completed?', 'time': 'Sat', 'isMe': true, 'seen': true, 'status': 'seen'},
      {'id': 'm2', 'senderId': '5', 'text': 'Of course 😎', 'time': 'Sat', 'isMe': false, 'seen': true, 'status': 'seen'},
    ],
  };

  static const Map<String, String> _names = {
    '1': 'Alice Johnson',
    '2': 'Bob Smith',
    '3': 'Charlie Brown',
    '4': 'Diana Prince',
    '5': 'Ethan Hunt',
  };

  @override
  Future<List<ChatContactModel>> getContacts() async {
    return _messagesData.entries.map((entry) {
      final msgs = entry.value;
      final last = msgs.isNotEmpty ? msgs.last : null;
      final unread = msgs.where((m) => !(m['isMe'] as bool) && !(m['seen'] as bool)).length;
      final isOnline = int.parse(entry.key) % 2 == 0;
      return ChatContactModel(
        id: entry.key,
        name: _names[entry.key] ?? 'Unknown',
        avatar: 'assets/avatar${entry.key}.png',
        lastMessage: last?['text'] as String? ?? '',
        lastMessageTime: last?['time'] as String? ?? '',
        unreadCount: unread,
        isOnline: isOnline,
      );
    }).toList();
  }

  @override
  Future<List<ChatMessageModel>> getMessages(String contactId) async {
    final raw = _messagesData[contactId] ?? [];
    return raw.map((m) => ChatMessageModel(
          id: m['id'] as String,
          senderId: m['senderId'] as String,
          text: m['text'] as String,
          time: m['time'] as String,
          isMe: m['isMe'] as bool,
          seen: m['seen'] as bool,
          status: MessageStatus.seen,
        )).toList();
  }
}
