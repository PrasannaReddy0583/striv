import 'package:striv/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:striv/features/chat/domain/entities/chat_contact.dart';
import 'package:striv/features/chat/domain/entities/chat_message.dart';
import 'package:striv/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDataSource localDataSource;

  ChatRepositoryImpl(this.localDataSource);

  @override
  Future<List<ChatContact>> getContacts() => localDataSource.getContacts();

  @override
  Future<List<ChatMessage>> getMessages(String contactId) =>
      localDataSource.getMessages(contactId);
}
