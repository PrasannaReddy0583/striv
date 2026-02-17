import 'package:flutter/material.dart';
import 'package:striv/pages/settings/app_theme.dart';

class AppInformationScreen extends StatelessWidget {
  const AppInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundTop,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AppBar Row
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppColors.heading,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 12),
                        Text("About & Contact", style: AppTextStyles.pageTitle),
                      ],
                    ),
                    const SizedBox(height: 20),

                    const SizedBox(height: 12),
                    Text("About Dealence", style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),
                    Text(
                      "Dealence is a platform connecting entrepreneurs with investors, fostering innovation and growth. "
                      "Our mission is to empower startups and drive impactful change.",
                      style: AppTextStyles.bodyText,
                    ),

                    const SizedBox(height: 20),

                    // Our Story
                    Text("Our Story", style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),
                    Text(
                      "We’re a passionate team dedicated to bridging the gap between visionary founders and strategic investors. "
                      "We believe that great ideas deserve the right support to flourish, and we’re here to make those connections happen.",
                      style: AppTextStyles.bodyText,
                    ),

                    const SizedBox(height: 20),

                    // Contact Us Title
                    Text("Contact Us", style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 8),

                    // Card for Contact Us (reduced top/bottom padding)
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ), // reduced top/bottom
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Email Support",
                              style: AppTextStyles.cardTitle,
                            ),
                            trailing: Text(
                              "support@dealence.app",
                              style: AppTextStyles.cardSubtitle,
                            ),
                          ),
                          Divider(
                            color: const Color.fromARGB(255, 255, 214, 176),
                            height: 1,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Website",
                              style: AppTextStyles.cardTitle,
                            ),
                            trailing: Text(
                              "dealence.app",
                              style: AppTextStyles.cardSubtitle,
                            ),
                          ),
                          Divider(
                            color: const Color.fromARGB(255, 255, 214, 176),
                            height: 1,
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "Social Media",
                              style: AppTextStyles.cardTitle,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.email_outlined,
                                  color: AppColors.subtitle,
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.share, color: AppColors.subtitle),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Version at bottom center
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(child: Text("Version 1.0.0")),
            ),
          ],
        ),
      ),
    );
  }
}
