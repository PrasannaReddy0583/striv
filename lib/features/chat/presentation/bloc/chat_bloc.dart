import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/chat/domain/usecases/chat_usecases.dart';
import 'package:striv/features/chat/presentation/bloc/chat_event.dart';
import 'package:striv/features/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetContactsUseCase getContacts;
  final GetMessagesUseCase getMessages;

  ChatBloc({required this.getContacts, required this.getMessages})
      : super(const ChatInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<LoadMessages>(_onLoadMessages);
  }

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatLoading());
    try {
      final contacts = await getContacts(const NoParams());
      emit(ContactsLoaded(contacts));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onLoadMessages(
    LoadMessages event,
    Emitter<ChatState> emit,
  ) async {
    emit(const ChatLoading());
    try {
      final messages = await getMessages(GetMessagesParams(event.contactId));
      emit(MessagesLoaded(contactId: event.contactId, messages: messages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}
