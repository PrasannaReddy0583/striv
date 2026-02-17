import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/pages/settings/app_information_screen.dart';
import 'package:striv/pages/settings/app_theme.dart';
import 'package:striv/pages/settings/blocked_users_screen.dart';
import 'package:striv/pages/settings/legal_information_screen.dart';
import 'package:striv/pages/settings/notifications_preferences_screen.dart';
import 'package:striv/pages/settings/push_notifications_preferences_screen.dart';
import 'package:striv/pages/settings/two_factor_auth_screen.dart';
// Import your theme/colors/text styles file

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Text(title, style: AppTextStyles.sectionTitle),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        title: Text(title, style: AppTextStyles.cardTitle),
        subtitle: Text(subtitle, style: AppTextStyles.cardSubtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: AppColors.subtitle,
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
            children: [
              // AppBar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20.0,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        CupertinoIcons.back,
                        color: AppColors.heading,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text("Settings", style: AppTextStyles.pageTitle),
                  ],
                ),
              ),

              // Content
              Expanded(
                child: ListView(
                  children: [
                    _buildSectionTitle("Account Settings"),
                    _buildListTile(
                      title: "Edit Profile",
                      subtitle: "Update your profile information",
                    ),
                    _buildListTile(
                      title: "Manage Linked Accounts",
                      subtitle: "Manage your connected accounts",
                    ),

                    _buildSectionTitle("Notification Preferences"),
                    _buildListTile(
                      title: "Email Notifications",
                      subtitle: "Control email notifications",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const NotificationPreferencesScreen(),
                          ),
                        );
                      },
                    ),
                    _buildListTile(
                      title: "Messages Notifications",
                      subtitle: "Control Messages notifications",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const PushNotificationPreferencesScreen(),
                          ),
                        );
                      },
                    ),

                    _buildSectionTitle("Privacy & Security"),
                    _buildListTile(
                      title: "Two-Factor Authentication",
                      subtitle: "Protect your account with extra security",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TwoFactorAuthScreen(),
                          ),
                        );
                      },
                    ),

                    _buildListTile(
                      title: "Blocked Users",
                      subtitle: "Manage blocked users",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BlockedUsersScreen(),
                          ),
                        );
                      },
                    ),
                    _buildSectionTitle("App Information"),
                    _buildListTile(
                      title: "Terms & Privacy Policy",
                      subtitle: "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const LegalInformationScreen(),
                          ),
                        );
                      },
                    ),
                    _buildListTile(
                      title: "About & Contact",
                      subtitle: "",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppInformationScreen(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              235,
                              182,
                              136,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () {},
                          child: Text(
                            "Logout",
                            style: AppTextStyles.cardTitle.copyWith(
                              color: AppColors.heading,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
