import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:striv/pages/settings/app_theme.dart'; // For blur

class BlockedUsersScreen extends StatefulWidget {
  const BlockedUsersScreen({super.key});

  @override
  State<BlockedUsersScreen> createState() => _BlockedUsersScreenState();
}

class _BlockedUsersScreenState extends State<BlockedUsersScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Dummy blocked users list
  List<Map<String, String>> blockedUsers = [
    {"name": "John Doe", "avatar": "JD"},
    {"name": "Alice Smith", "avatar": "AS"},
    {"name": "Robert Johnson", "avatar": "RJ"},
    {"name": "Sophia Williams", "avatar": "SW"},
  ];

  String searchQuery = "";

  bool _showUnblockMessage = false;
  String _unblockedUser = "";

  void _unblockUser(String name) {
    setState(() {
      blockedUsers.removeWhere((user) => user["name"] == name);
      _showUnblockMessage = true;
      _unblockedUser = name;
    });

    // Hide the message after 2 seconds
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showUnblockMessage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter users by search query
    final filteredUsers = blockedUsers
        .where(
          (user) =>
              user["name"]!.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.backgroundTop, AppColors.backgroundBottom],
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // AppBar row
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 20.0,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.heading,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 12),
                        Text("Blocked Users", style: AppTextStyles.pageTitle),
                      ],
                    ),
                  ),

                  // Search bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Search blocked users...",
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.subtitle,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(12),
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Blocked users list
                  Expanded(
                    child: filteredUsers.isEmpty
                        ? const Center(
                            child: Text(
                              "No blocked users found",
                              style: TextStyle(color: AppColors.subtitle),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: filteredUsers.length,
                            itemBuilder: (context, index) {
                              final user = filteredUsers[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.card,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Row(
                                  children: [
                                    // Avatar
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppColors.accent
                                          .withOpacity(0.4),
                                      child: Text(
                                        user["avatar"]!,
                                        style: AppTextStyles.cardTitle,
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Name
                                    Expanded(
                                      child: Text(
                                        user["name"]!,
                                        style: AppTextStyles.cardTitle,
                                      ),
                                    ),

                                    // Unblock button
                                    TextButton(
                                      onPressed: () =>
                                          _unblockUser(user["name"]!),
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.red,
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      child: const Text("Unblock"),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom floating message
        ),
        if (_showUnblockMessage)
          Positioned.fill(
            child: Stack(
              children: [
                // Blur background
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(color: Colors.black.withOpacity(0.2)),
                ),
                // Bottom message
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check, color: Colors.green),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "$_unblockedUser has been unblocked!",
                            style: AppTextStyles.cardTitle,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
