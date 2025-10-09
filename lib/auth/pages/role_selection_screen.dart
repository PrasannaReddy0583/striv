import 'package:flutter/material.dart';
import 'package:striv/core/constants.dart';
import 'package:striv/pages/entrepreneur/home_page.dart' hide AppColors;
// import 'package:dealence/entrepreneur_profile_setup_screen.dart';
// import 'package:dealence/investor_profile_setup_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

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
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Text(
                  'What\'s Your Role?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.pageTitle.copyWith(fontSize: 26),
                ),
                const SizedBox(height: 12),
                Text(
                  'Tell us what brings you to Dealence.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyText.copyWith(
                    color: AppColors.subtitle,
                  ),
                ),
                const Spacer(),
                _buildRoleCard(
                  context,
                  icon: Icons.lightbulb_outline,
                  title: 'I\'m an Entrepreneur',
                  description: 'Seeking funding for my innovative startup.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(isInvestor: true),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                _buildRoleCard(
                  context,
                  icon: Icons.account_balance_wallet_outlined,
                  title: 'I\'m an Investor',
                  description: 'Looking to find and fund promising ventures.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(isInvestor: true),
                      ),
                    );
                  },
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 48, color: AppColors.accent),
            const SizedBox(height: 15),
            Text(title, style: AppTextStyles.cardTitle.copyWith(fontSize: 20)),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyText.copyWith(color: AppColors.subtitle),
            ),
          ],
        ),
      ),
    );
  }
}
