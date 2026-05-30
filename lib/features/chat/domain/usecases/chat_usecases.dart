import 'package:equatable/equatable.dart';
import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/chat/domain/entities/chat_contact.dart';
import 'package:striv/features/chat/domain/entities/chat_message.dart';
import 'package:striv/features/chat/domain/repositories/chat_repository.dart';

class GetContactsUseCase implements UseCase<List<ChatContact>, NoParams> {
  final ChatRepository repository;
  GetContactsUseCase(this.repository);

  @override
  Future<List<ChatContact>> call(NoParams params) => repository.getContacts();
}

class GetMessagesParams extends Equatable {
  final String contactId;
  const GetMessagesParams(this.contactId);

  @override
  List<Object?> get props => [contactId];
}

class GetMessagesUseCase
    implements UseCase<List<ChatMessage>, GetMessagesParams> {
  final ChatRepository repository;
  GetMessagesUseCase(this.repository);

  @override
  Future<List<ChatMessage>> call(GetMessagesParams params) =>
      repository.getMessages(params.contactId);
}
