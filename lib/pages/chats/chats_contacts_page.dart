import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:striv/data/chat_data.dart';
import 'package:striv/pages/chats/chat_conversations_page.dart';
import 'package:striv/widgets/chat_tile.dart';
import 'package:striv/utils/app_palette.dart';

class ChatsContactsPage extends StatefulWidget {
  const ChatsContactsPage({super.key, required this.isInvestor});

  final bool isInvestor;

  @override
  State<ChatsContactsPage> createState() => _ChatsContactsPageState();
}

class _ChatsContactsPageState extends State<ChatsContactsPage> {
  late List chats;

  @override
  void initState() {
    super.initState();
    // Get the initial chats from DummyData
    chats = DummyData.chats;
  }

  void _refreshChat(String chatId) {
    // Get latest messages for this chat
    final messages = DummyData.messages[chatId] ?? [];
    final lastMessage = messages.isNotEmpty ? messages.last : null;

    final unreadCount = messages
        .where((m) => !m.isMe && !m.seen)
        .length; // unseen messages

    // Update the chat in list
    final chatIndex = chats.indexWhere((c) => c.id == chatId);
    if (chatIndex != -1) {
      chats[chatIndex].lastMessage = lastMessage?.text ?? "";
      chats[chatIndex].lastMessageTime = lastMessage?.time ?? "";
      chats[chatIndex].unread = unreadCount;
    }

    setState(() {}); // refresh UI
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppPalette.background,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Chats",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.textPrimary,
                      ),
                    ),
                    CircleAvatar(
                      radius: 21,
                      backgroundColor: AppPalette.white,
                      child: Icon(Icons.edit, color: AppPalette.black),
                    ),
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(
                        CupertinoIcons.search,
                        color: AppPalette.iconColor,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Chats List
              Expanded(
                child: ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return ChatTile(
                      id: chat.id,
                      name: chat.name,
                      message: chat.lastMessage,
                      time: chat.lastMessageTime,
                      avatar: chat.avatar,
                      unread: chat.unread,
                      onTap: () async {
                        // Open the conversation page
                        await Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => ChatConversationPage(chat: chat),
                          ),
                        );

                        // Refresh chat info after returning
                        _refreshChat(chat.id);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
