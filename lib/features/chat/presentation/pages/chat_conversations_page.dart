import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/features/chat/domain/entities/chat_contact.dart';
import 'package:striv/features/chat/domain/entities/chat_message.dart';
import 'package:striv/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:striv/features/chat/presentation/bloc/chat_event.dart';
import 'package:striv/features/chat/presentation/bloc/chat_state.dart';
import 'package:striv/utils/app_palette.dart';

class ChatConversationPage extends StatelessWidget {
  final ChatContact chat;

  const ChatConversationPage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(LoadMessages(chat.id));

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final messages =
            state is MessagesLoaded ? state.messages : <ChatMessage>[];

        return Scaffold(
          backgroundColor: AppPalette.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppPalette.background,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(CupertinoIcons.back,
                  color: AppPalette.black, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(chat.avatar),
                  radius: 16,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.circle,
                            color:
                                chat.isOnline ? Colors.green : Colors.black,
                            size: 8),
                        const SizedBox(width: 4),
                        Text(
                          chat.isOnline ? "Online" : "Offline",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                  icon: const Icon(CupertinoIcons.phone, color: Colors.black),
                  onPressed: () {}),
              IconButton(
                  icon: const Icon(CupertinoIcons.video_camera,
                      color: Colors.black, size: 32),
                  onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  onPressed: () {}),
            ],
          ),
          body: Column(
            children: [
              if (state is ChatLoading)
                const Expanded(
                    child: Center(child: CircularProgressIndicator()))
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[messages.length - 1 - index];
                      return ChatBubble(
                        text: msg.text,
                        time: msg.time,
                        isSender: msg.isMe,
                        avatar: msg.isMe ? "assets/my_avatar.png" : chat.avatar,
                        status: msg.status,
                      );
                    },
                  ),
                ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppPalette.background,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(0, -1),
                        blurRadius: 4)
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: AppPalette.transparent,
                            borderRadius: BorderRadius.circular(24)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            cursorColor: AppPalette.black,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppPalette.primaryBackground,
                              hintText: "Type a message...",
                              hintStyle: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  color: AppPalette.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                        icon: const Icon(Icons.attach_file,
                            color: AppPalette.black),
                        onPressed: () {}),
                    Container(
                      decoration: const BoxDecoration(
                          color: AppPalette.messageColor,
                          shape: BoxShape.circle),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(Icons.send,
                          color: AppPalette.white, size: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final String time;
  final bool isSender;
  final String avatar;
  final MessageStatus status;

  const ChatBubble({
    super.key,
    required this.text,
    required this.time,
    required this.isSender,
    required this.avatar,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isSender) ...[
                CircleAvatar(
                  minRadius: 16,
                  backgroundColor: AppPalette.messageColor,
                  child: CircleAvatar(
                      backgroundImage: AssetImage(avatar), radius: 14),
                ),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        isSender ? AppPalette.messageColor : AppPalette.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(text,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14,
                          color: isSender ? Colors.white : Colors.black)),
                ),
              ),
              if (isSender) ...[
                const SizedBox(width: 6),
                CircleAvatar(
                  minRadius: 16,
                  backgroundColor: AppPalette.messageColor,
                  child: CircleAvatar(
                      backgroundImage: AssetImage(avatar), radius: 14),
                ),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment:
                isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 11,
                      color: Colors.grey[600])),
              if (isSender && status == MessageStatus.sent)
                const Icon(CupertinoIcons.checkmark_alt, size: 18),
              if (isSender && status == MessageStatus.delivered)
                Icon(CupertinoIcons.checkmark_alt,
                    size: 18, color: AppPalette.unseen),
              if (isSender && status == MessageStatus.seen)
                Icon(CupertinoIcons.checkmark_alt,
                    size: 18, color: AppPalette.seen),
            ],
          ),
        ],
      ),
    );
  }
}
