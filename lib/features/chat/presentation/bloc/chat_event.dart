import 'package:equatable/equatable.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

class LoadContacts extends ChatEvent {
  const LoadContacts();
}

class LoadMessages extends ChatEvent {
  final String contactId;
  const LoadMessages(this.contactId);

  @override
  List<Object?> get props => [contactId];
}
