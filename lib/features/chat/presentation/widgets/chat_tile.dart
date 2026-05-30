import 'package:flutter/material.dart';
import 'package:striv/utils/app_palette.dart';

class ChatTile extends StatelessWidget {
  final String id;
  final String name;
  final String message;
  final String time;
  final int unread;
  final String avatar;
  final VoidCallback? onTap;

  const ChatTile({
    super.key,
    required this.id,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.onTap,
    this.unread = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 25,
      onTap: onTap, // Use the callback passed from parent
      leading: CircleAvatar(backgroundImage: AssetImage(avatar), radius: 26),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppPalette.textPrimary,
        ),
      ),
      subtitle: Text(
        message,
        style: const TextStyle(color: AppPalette.black),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: AppPalette.black),
          ),
          if (unread > 0)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.orange,
                child: Text(
                  "$unread",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
