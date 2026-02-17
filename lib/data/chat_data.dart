import 'package:striv/entites/chat.dart';
import 'package:striv/entites/message.dart';

class DummyData {
  // Chats list will be derived from messages for lastMessage and unread
  static final Map<String, List<Message>> messages = {
    "1": [
      Message(
        id: "m1",
        senderId: "1",
        text: "Hey Alice, how are you?",
        time: "9:30 AM",
        isMe: true,
        seen: true,
        status: MessageStatus.seen,
      ),
      Message(
        id: "m2",
        senderId: "1",
        text: "Doing great! You?",
        time: "9:32 AM",
        isMe: false,
        seen: true,
        status: MessageStatus.seen,
      ),
      Message(
        id: "m3",
        senderId: "me",
        text: "All good. Let’s meet soon.",
        time: "9:40 AM",
        isMe: true,
        seen: false,
        status: MessageStatus.seen,
      ),
    ],
    "2": [
      Message(
        id: "m1",
        senderId: "2",
        text: "How’s the project going?",
        time: "Yesterday",
        isMe: false,
        seen: true,
        status: MessageStatus.seen,
      ),
      Message(
        id: "m2",
        senderId: "me",
        text: "Almost done 🚀",
        time: "Yesterday",
        isMe: true,
        seen: true,
        status: MessageStatus.seen,
      ),
    ],
    "3": [
      Message(
        id: "m1",
        senderId: "me",
        text: "Hey Charlie, free today?",
        time: "Mon",
        isMe: true,
        seen: true,
        status: MessageStatus.seen,
      ),
      Message(
        id: "m2",
        senderId: "3",
        text: "Not really, busy day 😅",
        time: "Mon",
        isMe: false,
        seen: false,
        status: MessageStatus.seen,
      ),
    ],
    "4": [
      Message(
        id: "m1",
        senderId: "4",
        text: "Did you review the doc?",
        time: "Sun",
        isMe: false,
        seen: true,
        status: MessageStatus.seen,
      ),
      Message(
        id: "m2",
        senderId: "me",
        text: "Yes, looks good 👍",
        time: "Sun",
        isMe: true,
        seen: true,
        status: MessageStatus.seen,
      ),
    ],
    "5": [
      Message(
        id: "m1",
        senderId: "me",
        text: "Mission completed?",
        time: "Sat",
        isMe: true,
        seen: true,
        status: MessageStatus.seen,
      ),
      Message(
        id: "m2",
        senderId: "5",
        text: "Of course 😎",
        time: "Sat",
        isMe: false,
        seen: true,
        status: MessageStatus.seen,
      ),
    ],
  };

  // Chats derived from messages to ensure last message & unread count are correct
  static List<Chat> get chats {
    return messages.entries.map((entry) {
      final msgs = entry.value;
      final lastMsg = msgs.isNotEmpty ? msgs.last : null;

      final unreadCount = msgs
          .where((m) => !m.isMe && !m.seen)
          .length; // Only count messages from others that are unseen

      final isOnline = (int.parse(entry.key) % 2 == 0);

      return Chat(
        id: entry.key,
        name: _getNameById(entry.key),
        avatar: "assets/avatar${entry.key}.png",
        lastMessage: lastMsg?.text ?? "",
        lastMessageTime: lastMsg?.time ?? "",
        unread: unreadCount,
        isOnline: isOnline,
      );
    }).toList();
  }

  // Helper to give dummy names based on id
  static String _getNameById(String id) {
    switch (id) {
      case "1":
        return "Alice Johnson";
      case "2":
        return "Bob Smith";
      case "3":
        return "Charlie Brown";
      case "4":
        return "Diana Prince";
      case "5":
        return "Ethan Hunt";
      default:
        return "Unknown";
    }
  }
}
