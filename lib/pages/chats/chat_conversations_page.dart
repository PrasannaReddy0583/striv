import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/data/chat_data.dart';
import 'package:striv/entites/chat.dart';
import 'package:striv/entites/message.dart';
import '../../utils/app_palette.dart';

class ChatConversationPage extends StatefulWidget {
  final Chat chat;

  const ChatConversationPage({super.key, required this.chat});

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  late List<Message> messages;

  @override
  void initState() {
    super.initState();
    messages = DummyData.messages[widget.chat.id] ?? [];

    // Mark all incoming (not sent by me) unseen messages as seen
    for (var msg in messages) {
      if (!msg.isMe && !msg.seen) {
        msg.seen = true; // This updates the status in memory
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppPalette.background,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.back,
            color: AppPalette.black,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 16,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.chat.avatar),
              radius: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat.name,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: widget.chat.isOnline ? Colors.green : Colors.black,
                      size: 8,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.chat.isOnline ? "Online" : "Offline",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
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
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              CupertinoIcons.video_camera,
              color: Colors.black,
              size: 32,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final msg = messages[messages.length - 1 - index];
                return ChatBubble(
                  text: msg.text,
                  time: msg.time,
                  isSender: msg.isMe,
                  avatar: msg.isMe
                      ? "assets/my_avatar.png"
                      : widget.chat.avatar,
                  status: msg.status,
                );
              },
            ),
          ),

          // Message input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: AppPalette.background,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, -1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppPalette.transparent,
                      borderRadius: BorderRadius.circular(24),
                    ),
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
                            color: AppPalette.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.attach_file, color: AppPalette.black),
                  onPressed: () {},
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppPalette.messageColor,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(
                    Icons.send,
                    color: AppPalette.white,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
        crossAxisAlignment: isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isSender)
                CircleAvatar(
                  minRadius: 16,
                  backgroundColor: AppPalette.messageColor,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatar),
                    radius: 14,
                  ),
                ),
              if (!isSender) const SizedBox(width: 6),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSender
                        ? AppPalette.messageColor
                        : AppPalette.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      color: isSender ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              if (isSender) const SizedBox(width: 6),
              if (isSender)
                CircleAvatar(
                  minRadius: 16,
                  backgroundColor: AppPalette.messageColor,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatar),
                    radius: 14,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
              if (isSender && status == MessageStatus.sent)
                const Icon(CupertinoIcons.checkmark_alt, size: 18),
              if (isSender && status == MessageStatus.delivered)
                Icon(
                  CupertinoIcons.checkmark_alt,
                  size: 18,
                  color: AppPalette.unseen,
                ),
              if (isSender && status == MessageStatus.seen)
                Icon(
                  CupertinoIcons.checkmark_alt,
                  size: 18,
                  color: AppPalette.seen,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
