import 'package:flutter/material.dart';
import 'package:striv/pages/settings/app_theme.dart';
import 'package:striv/pages/settings/settings_screen.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
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

              // Email Notifications title outside the card
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: Text(
                  "Email Notifications",
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
                            newMatchesEnabled,
                            (val) {
                              setState(() => newMatchesEnabled = val);
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchTile(
                            "Push Notifications",
                            newMatchesPush,
                            (val) {
                              setState(() => newMatchesPush = val);
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchTile(
                            "Email Notifications",
                            newMatchesEmail,
                            (val) {
                              setState(() => newMatchesEmail = val);
                            },
                          ),
                          _buildDivider(),
                          _buildSwitchTile("In-App Alerts", newMatchesInApp, (
                            val,
                          ) {
                            setState(() => newMatchesInApp = val);
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
