import 'package:equatable/equatable.dart';
import 'package:striv/features/chat/domain/entities/chat_contact.dart';
import 'package:striv/features/chat/domain/entities/chat_message.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {
  const ChatLoading();
}

class ContactsLoaded extends ChatState {
  final List<ChatContact> contacts;
  const ContactsLoaded(this.contacts);

  @override
  List<Object?> get props => [contacts];
}

class MessagesLoaded extends ChatState {
  final String contactId;
  final List<ChatMessage> messages;

  const MessagesLoaded({required this.contactId, required this.messages});

  @override
  List<Object?> get props => [contactId, messages];
}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
