import 'package:flutter/material.dart';
import 'package:striv/pages/settings/app_theme.dart';

class LegalInformationScreen extends StatelessWidget {
  const LegalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.backgroundTop,
      body: SafeArea(
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
                  Text("Legal Information", style: AppTextStyles.pageTitle),
                ],
              ),
              const SizedBox(height: 20),

              // Terms of Service
              Text("Terms & Privacy Policy", style: AppTextStyles.sectionTitle),
              const SizedBox(height: 8),
              Text(
                "Welcome to our platform! By accessing or using our services, you agree to be bound by these Terms of Service. "
                "Please read them carefully. If you do not agree to these terms, you should not use our services. "
                "These terms govern your use of our platform and any related services, including any content, functionality, "
                "and features offered through our platform.\n\n"
                "We reserve the right to modify these terms at any time, and your continued use of the platform constitutes "
                "acceptance of those changes. It is your responsibility to review these terms periodically for updates.\n\n"
                "1. User Responsibilities:\n"
                "- You agree to provide accurate and current information when using the platform.\n"
                "- You are responsible for maintaining the confidentiality of your account and password.\n"
                "- You must not use the platform for illegal purposes or violate any applicable laws.\n\n"
                "2. Intellectual Property:\n"
                "- All content on the platform, including text, graphics, logos, and software, is the property of the platform or its licensors.\n"
                "- You may not copy, reproduce, or distribute any content without prior written permission.\n\n"
                "3. Termination:\n"
                "- We reserve the right to suspend or terminate your account for violations of these terms.\n"
                "- Upon termination, your rights to access the platform immediately cease.\n\n"
                "4. Limitation of Liability:\n"
                "- We are not liable for any indirect, incidental, or consequential damages arising from your use of the platform.\n"
                "- Our total liability, whether in contract, tort, or otherwise, is limited to the amount you paid for using the platform, if any.\n\n"
                "5. Governing Law:\n"
                "- These terms are governed by and construed in accordance with the laws of the applicable jurisdiction.\n"
                "- Any disputes arising from these terms shall be subject to the exclusive jurisdiction of the courts in the specified jurisdiction.\n\n"
                "We encourage all users to read and understand these Terms & Privacy Policy to ensure a safe and responsible experience.",
                style: AppTextStyles.bodyText,
              ),
              const SizedBox(height: 8),
              Text(
                "Last Updated: January 1, 2024",
                style: AppTextStyles.bodyText.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                ),
              ),

              const SizedBox(height: 24),

              // Privacy Policy
              Text("Privacy Policy", style: AppTextStyles.sectionTitle),
              const SizedBox(height: 8),
              Text(
                "Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your personal "
                "information when you use our platform. We collect information you provide directly, such as when you register, "
                "create content, or communicate with us. We also collect information automatically, such as your IP address, "
                "device information, and usage data.\n\n"
                "We use your information to provide and improve our services, personalize your experience, communicate with you, "
                "and ensure the security of our platform. We do not sell your personal information to third parties. "
                "We may share your information with service providers who assist us in operating our platform, subject to confidentiality agreements. "
                "We take reasonable measures to protect your information from unauthorized access, use, or disclosure.\n\n"
                "1. Data Collection:\n"
                "- We collect personal information you provide directly, such as your name, email, and profile information.\n"
                "- We automatically collect usage information including device type, IP address, and session data.\n"
                "- Cookies and similar technologies may be used to enhance user experience.\n\n"
                "2. Data Usage:\n"
                "- Your data is used to provide services, send notifications, improve features, and personalize content.\n"
                "- Information may be used for internal analytics and reporting purposes.\n"
                "- We may use anonymized or aggregated data for research or marketing purposes.\n\n"
                "3. Data Sharing:\n"
                "- We do not sell personal information to third parties.\n"
                "- We may share information with trusted service providers for operational purposes.\n"
                "- Legal obligations may require disclosure of information to comply with laws or enforce terms of service.\n\n"
                "4. User Rights:\n"
                "- You can access, update, or delete your personal information by contacting support.\n"
                "- You may opt-out of marketing communications at any time.\n"
                "- Certain data may be retained for legal or operational reasons.\n\n"
                "5. Security Measures:\n"
                "- We implement reasonable technical and administrative safeguards to protect your data.\n"
                "- Despite these measures, no system can be completely secure. Users are encouraged to use strong passwords and secure devices.\n\n"
                "By continuing to use the platform, you acknowledge that you have read, understood, and agreed to this Privacy Policy. "
                "We recommend reviewing this policy periodically for any updates or changes.",
                style: AppTextStyles.bodyText,
              ),
              const SizedBox(height: 8),
              Text(
                "Last Updated: January 1, 2024",
                style: AppTextStyles.bodyText.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
