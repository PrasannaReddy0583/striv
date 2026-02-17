import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/utils/app_theme.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(CupertinoIcons.back),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Terms and Conditions',
            style: AppTextStyles.pageTitle.copyWith(fontSize: 20),
          ),
        ),
        backgroundColor: AppColors.backgroundTop,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.heading),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(context, '1. Acceptance of Terms'),
                _buildParagraph(
                  context,
                  'By accessing or using the Dealence application ("App"), you agree to be bound by these Terms and Conditions and our Privacy Policy. If you do not agree to these terms, please do not use our App.',
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '2. User Accounts'),
                _buildParagraph(
                  context,
                  'You must be at least 18 years old to create an account. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.',
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '3. User Conduct'),
                _buildParagraph(
                  context,
                  'You agree not to use the App for any unlawful purpose or in any way that could damage, disable, overburden, or impair the App or interfere with any other party\'s use and enjoyment of the App.',
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '4. Intellectual Property'),
                _buildParagraph(
                  context,
                  'All content and materials available on the App, including but not limited to text, graphics, logos, images, and software, are the property of Dealence or its licensors and are protected by copyright, trademark, and other intellectual property laws.',
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '5. Disclaimers'),
                _buildParagraph(
                  context,
                  'The App is provided "as is" and "as available" without any warranties, express or implied. Dealence does not warrant that the App will be uninterrupted, error-free, or free from viruses or other harmful components.',
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '6. Limitation of Liability'),
                _buildParagraph(
                  context,
                  'In no event shall Dealence be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from (i) your access to or use of or inability to access or use the App; (ii) any conduct or content of any third party on the App; (iii) any content obtained from the App; and (iv) unauthorized access, use or alteration of your transmissions or content, whether based on warranty, contract, tort (including negligence) or any other legal theory, whether or not we have been informed of the possibility of such damage, and even if a remedy set forth herein is found to have failed of its essential purpose.',
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '7. Governing Law'),
                _buildParagraph(
                  context,
                  'These Terms shall be governed and construed in accordance with the laws of India, without regard to its conflict of law provisions.',
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '8. Changes to Terms'),
                _buildParagraph(
                  context,
                  'We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will try to provide at least 30 days notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.',
                ),
                const SizedBox(height: 16),
                _buildSectionTitle(context, '9. Contact Us'),
                _buildParagraph(
                  context,
                  'If you have any questions about these Terms, please contact us at support@dealence.com.',
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    'Last updated: September 26, 2025',
                    style: AppTextStyles.cardSubtitle.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: AppTextStyles.cardTitle.copyWith(color: AppColors.heading),
      ),
    );
  }

  Widget _buildParagraph(BuildContext context, String text) {
    return Text(
      text,
      style: AppTextStyles.bodyText.copyWith(color: AppColors.textBody),
      textAlign: TextAlign.justify,
    );
  }
}
