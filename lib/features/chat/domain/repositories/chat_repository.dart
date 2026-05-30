import 'package:striv/features/chat/domain/entities/chat_contact.dart';
import 'package:striv/features/chat/domain/entities/chat_message.dart';

abstract class ChatRepository {
  Future<List<ChatContact>> getContacts();
  Future<List<ChatMessage>> getMessages(String contactId);
}
