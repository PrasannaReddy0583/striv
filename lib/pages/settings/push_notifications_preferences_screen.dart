import 'package:flutter/material.dart';
import 'package:striv/pages/settings/app_theme.dart';
import 'package:striv/pages/settings/settings_screen.dart';

class PushNotificationPreferencesScreen extends StatefulWidget {
  const PushNotificationPreferencesScreen({super.key});

  @override
  State<PushNotificationPreferencesScreen> createState() =>
      _PushNotificationPreferencesScreenState();
}

class _PushNotificationPreferencesScreenState
    extends State<PushNotificationPreferencesScreen> {
  bool newMatchesEnabled = false;
  bool newMatchesPush = false;
  bool newMatchesEmail = false;
  bool newMatchesInApp = false;

  bool messagesEnabled = false;
  bool messagesPush = false;
  bool messagesEmail = false;
  bool messagesInApp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Custom AppBar
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
                        Icons.arrow_back,
                        color: AppColors.heading,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        "Notification Preferences",
                        style: AppTextStyles.pageTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Section title outside the card (same as email screen)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Text(
                  "Messages Notifications",
                  style: AppTextStyles.sectionTitle,
                ),
              ),

              // Card with switches
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSwitchTile(
                            "Enable Notifications",
                            messagesEnabled,
                            (val) {
                              setState(() => messagesEnabled = val);
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchTile("Push Notifications", messagesPush, (
                            val,
                          ) {
                            setState(() => messagesPush = val);
                          }),
                          _buildDivider(),
                          _buildSwitchTile(
                            "Email Notifications",
                            messagesEmail,
                            (val) {
                              setState(() => messagesEmail = val);
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchTile("In-App Alerts", messagesInApp, (
                            val,
                          ) {
                            setState(() => messagesInApp = val);
                          }),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Save Changes Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          // Navigate directly to Settings screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Save Changes",
                          style: AppTextStyles.cardTitle.copyWith(
                            color: AppColors.heading,
                            fontWeight: FontWeight.w600,
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

  Widget _buildSwitchTile(
    String text,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      activeThumbColor: AppColors.heading,
      title: Text(text, style: AppTextStyles.cardTitle),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1,
      color: const Color.fromARGB(255, 255, 214, 176),
      margin: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}
