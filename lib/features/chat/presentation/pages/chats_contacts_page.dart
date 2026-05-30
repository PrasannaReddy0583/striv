import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/features/chat/domain/entities/chat_contact.dart';
import 'package:striv/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:striv/features/chat/presentation/bloc/chat_event.dart';
import 'package:striv/features/chat/presentation/bloc/chat_state.dart';
import 'package:striv/features/chat/presentation/pages/chat_conversations_page.dart';
import 'package:striv/utils/app_palette.dart';
import 'package:striv/features/chat/presentation/widgets/chat_tile.dart';

class ChatsContactsPage extends StatelessWidget {
  const ChatsContactsPage({super.key, required this.isInvestor});

  final bool isInvestor;

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(const LoadContacts());

    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final contacts =
            state is ContactsLoaded ? state.contacts : <ChatContact>[];

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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
                  if (state is ChatLoading)
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final chat = contacts[index];
                          return ChatTile(
                            id: chat.id,
                            name: chat.name,
                            message: chat.lastMessage,
                            time: chat.lastMessageTime,
                            avatar: chat.avatar,
                            unread: chat.unreadCount,
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) =>
                                      ChatConversationPage(chat: chat),
                                ),
                              );
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
      },
    );
  }
}
