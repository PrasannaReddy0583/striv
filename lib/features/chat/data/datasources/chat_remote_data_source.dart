// ---------------------------------------------------------------------------
// REMOTE DATA SOURCE — swap ChatLocalDataSourceImpl → ChatRemoteDataSourceImpl
// in injection_container.dart once the backend is ready.
// ---------------------------------------------------------------------------
import 'package:dio/dio.dart';
import 'package:striv/core/errors/exceptions.dart';
import 'package:striv/features/chat/data/models/chat_contact_model.dart';
import 'package:striv/features/chat/data/models/chat_message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatContactModel>> getContacts();
  Future<List<ChatMessageModel>> getMessages(String contactId);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio;
  ChatRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ChatContactModel>> getContacts() async {
    try {
      final res = await dio.get('/chats');
      return (res.data as List)
          .map((j) => ChatContactModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load chats');
    }
  }

  @override
  Future<List<ChatMessageModel>> getMessages(String contactId) async {
    try {
      final res = await dio.get('/chats/$contactId/messages');
      return (res.data as List)
          .map((j) => ChatMessageModel.fromJson(j as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Failed to load messages');
    }
  }
}
