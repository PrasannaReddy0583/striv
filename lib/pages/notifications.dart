import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color bgColor = Color(0xFFF6EEE5);
  static const Color cardColor = Color(0xFFF8F3ED);
  static const Color chipColor = Color(0xFFF6EEE6);
  static const Color selectedChipColor = Color(0xFFEAD2BD);
  static const Color unselectedChipColor = Color(0xFFF8F3ED);
  static const Color primaryText = Color(0xFF8B7F75);
  static const Color dotColor = Color(0xFF8B7F75);
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<String> categories = ['All', 'Unread', 'Pitches', 'Messages'];
  int selectedCategory = 0;

  List<_NotifItem> notifications = [
    _NotifItem(
      title: 'Tech Innovators Inc. requested to connect',
      time: '2h ago',
      icon: Icons.business_center_outlined,
      isUnread: true,
    ),
    _NotifItem(
      title: 'You received new feedback on your pitch',
      time: '3h ago',
      icon: Icons.feedback_outlined,
      isUnread: true,
    ),
    _NotifItem(
      title: 'Ethan Carter messaged you',
      time: '4h ago',
      avatarColor: Colors.grey.shade300,
      avatarInitials: 'E',
      isUnread: true,
    ),
    _NotifItem(
      title: 'New post in AI Investors Group',
      time: '5h ago',
      icon: Icons.group_outlined,
      isUnread: false,
    ),
    _NotifItem(
      title: 'Olivia Bennett messaged you',
      time: 'Yesterday',
      avatarUrl: 'https://i.pravatar.cc/150?img=47',
      isUnread: false,
    ),
  ];

  void markAllRead() {
    setState(() {
      for (var n in notifications) n.isUnread = false;
    });
  }

  List<_NotifItem> get filteredNotifications {
    if (selectedCategory == 0) return notifications;
    if (selectedCategory == 1) {
      return notifications.where((n) => n.isUnread).toList();
    }
    if (selectedCategory == 2) {
      return notifications
          .where(
            (n) =>
                n.title.toLowerCase().contains('pitch') ||
                n.title.toLowerCase().contains('requested'),
          )
          .toList();
    }
    if (selectedCategory == 3) {
      return notifications
          .where((n) => n.title.toLowerCase().contains('messag'))
          .toList();
    }
    return notifications;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          surfaceTintColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(CupertinoIcons.back, size: 30),
          ),
          title: Text(
            'Notifications',
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: markAllRead,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Mark All as Read',
                      style: TextStyle(
                        color: AppColors.primaryText.withOpacity(0.85),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Categories chips
              SizedBox(
                height: 40, // smaller height
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => SizedBox(width: 10),
                  itemBuilder: (context, idx) {
                    final bool selected = selectedCategory == idx;
                    return GestureDetector(
                      onTap: () => setState(() => selectedCategory = idx),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 220),
                        alignment: Alignment.center,
                        constraints: BoxConstraints(
                          minHeight: 40,
                          minWidth: 70,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.selectedChipColor
                              : AppColors.unselectedChipColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          categories[idx],
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontSize: 13,
                            fontWeight: selected
                                ? FontWeight.w700
                                : FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Expanded(
                child: ListView.separated(
                  itemCount: filteredNotifications.length,
                  separatorBuilder: (_, __) => SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final item = filteredNotifications[index];
                    return _NotificationCard(
                      item: item,
                      cardColor: AppColors.cardColor,
                      titleColor: AppColors.primaryText,
                      dotColor: AppColors.dotColor,
                      onTap: () {
                        setState(() {
                          item.isUnread = false;
                        });
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

class _NotifItem {
  String title;
  String time;
  IconData? icon;
  bool isUnread;
  String? avatarUrl;
  Color? avatarColor;
  String? avatarInitials;

  _NotifItem({
    required this.title,
    required this.time,
    this.icon,
    this.isUnread = false,
    this.avatarUrl,
    this.avatarColor,
    this.avatarInitials,
  });
}

class _NotificationCard extends StatelessWidget {
  final _NotifItem item;
  final Color cardColor;
  final Color titleColor;
  final Color dotColor;
  final VoidCallback? onTap;

  _NotificationCard({
    required this.item,
    required this.cardColor,
    required this.titleColor,
    required this.dotColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor, // ✅ use #F8F3ED
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 14,
              offset: Offset(0, 8),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (item.isUnread)
              Container(
                width: 8,
                height: 8,
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              )
            else
              SizedBox(width: 18),

            if (item.avatarUrl != null)
              CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage(item.avatarUrl!),
                backgroundColor: Colors.grey.shade200,
              )
            else if (item.avatarInitials != null)
              CircleAvatar(
                radius: 22,
                backgroundColor: item.avatarColor ?? Colors.grey.shade300,
                child: Text(
                  item.avatarInitials!,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              )
            else
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon ?? Icons.notifications_outlined,
                  color: titleColor.withOpacity(0.85),
                ),
              ),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      color: titleColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),
                  Text(
                    item.time,
                    style: TextStyle(
                      color: titleColor.withOpacity(0.6),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 8),
            Icon(Icons.chevron_right, color: titleColor.withOpacity(0.4)),
          ],
        ),
      ),
    );
  }
}
