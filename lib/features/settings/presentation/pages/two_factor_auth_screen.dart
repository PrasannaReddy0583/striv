import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:striv/core/theme/app_text_styles.dart';
import 'package:striv/core/theme/app_colors.dart';

class TwoFactorAuthScreen extends StatefulWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  bool _is2FAEnabled = false;
  String _selectedMethod = "Authenticator App";

  // Just a short placeholder secret (so it won’t overflow)
  final String _secretKey = "ABCD-1234";

  void _toggle2FA(bool value) {
    setState(() {
      _is2FAEnabled = value;
    });
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _is2FAEnabled
              ? "Two-Factor Authentication enabled ($_selectedMethod)"
              : "Two-Factor Authentication disabled",
        ),
        backgroundColor: _is2FAEnabled ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  void _copyKey() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Secret key copied to clipboard"),
        duration: Duration(seconds: 2),
      ),
    );
    // For real copy: Clipboard.setData(ClipboardData(text: _secretKey));
  }

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
          child: SingleChildScrollView(
            // <-- added scroll
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar Row
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
                          color: AppColors.textHeading,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 12),
                      Flexible(
                        child: Text(
                          "Two-Factor Authentication",
                          style: AppTextStyles.pageTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // Info Card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      "Add an extra layer of security to your account. "
                      "When enabled, you’ll be asked for a verification code in addition to your password.",
                      style: AppTextStyles.cardSubtitle,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Enable/Disable toggle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SwitchListTile(
                      title: Text("Enable 2FA", style: AppTextStyles.cardTitle),
                      value: _is2FAEnabled,
                      activeThumbColor: AppColors.accent,
                      onChanged: _toggle2FA,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Verification Methods
                if (_is2FAEnabled)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Verification Method",
                              style: AppTextStyles.cardTitle,
                            ),
                          ),
                          RadioListTile<String>(
                            title: const Text("Authenticator App"),
                            value: "Authenticator App",
                            groupValue: _selectedMethod,
                            activeColor: AppColors.accent,
                            onChanged: (val) =>
                                setState(() => _selectedMethod = val!),
                          ),
                          RadioListTile<String>(
                            title: const Text("SMS"),
                            value: "SMS",
                            groupValue: _selectedMethod,
                            activeColor: AppColors.accent,
                            onChanged: (val) =>
                                setState(() => _selectedMethod = val!),
                          ),
                          RadioListTile<String>(
                            title: const Text("Email"),
                            value: "Email",
                            groupValue: _selectedMethod,
                            activeColor: AppColors.accent,
                            onChanged: (val) =>
                                setState(() => _selectedMethod = val!),
                          ),
                        ],
                      ),
                    ),
                  ),

                // QR Code Card for Authenticator App
                if (_is2FAEnabled && _selectedMethod == "Authenticator App")
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          QrImageView(
                            data: "YourApp-2FA-Setup",
                            version: QrVersions.auto,
                            size: 140,
                          ),
                          const SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Secret: $_secretKey",
                                style: AppTextStyles.cardSubtitle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: _copyKey,
                                  child: const Text("Copy"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(
                  height: 16,
                ), // optional spacer instead of Spacer()
                // Save Button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveSettings,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          249,
                          231,
                          214,
                        ),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Save Settings",
                        style: AppTextStyles.cardTitle.copyWith(
                          color: AppColors.textHeading,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
}

// import 'package:flutter/material.dart';
// import 'app_theme.dart';

// class TwoFactorAuthScreen extends StatefulWidget {
//   const TwoFactorAuthScreen({super.key});

//   @override
//   State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
// }

// class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
//   bool _is2FAEnabled = false;
//   String _selectedMethod = "Authenticator App";

//   void _toggle2FA(bool value) {
//     setState(() {
//       _is2FAEnabled = value;
//     });
//   }

//   void _saveSettings() {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           _is2FAEnabled
//               ? "Two-Factor Authentication enabled ($_selectedMethod)"
//               : "Two-Factor Authentication disabled",
//         ),
//         backgroundColor: _is2FAEnabled ? Colors.green : Colors.red,
//         duration: const Duration(seconds: 2),
//       ),
//     );
//     Navigator.pop(context); // go back after saving
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [AppColors.backgroundTop, AppColors.backgroundBottom],
//           ),
//         ),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // AppBar Row
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//                 child: Row(
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.arrow_back, color: AppColors.textHeading),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                     const SizedBox(width: 12),
//                     Text("Two-Factor",
//                         style: AppTextStyles.pageTitle),
//                   ],
//                 ),
//               ),

//               // Info Card
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: AppColors.card,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Text(
//                     "Add an extra layer of security to your account. "
//                     "When enabled, you’ll be asked for a verification code in addition to your password.",
//                     style: AppTextStyles.cardSubtitle,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Enable/Disable toggle
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: AppColors.card,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: SwitchListTile(
//                     title: Text("Enable 2FA", style: AppTextStyles.cardTitle),
//                     value: _is2FAEnabled,
//                     activeColor: AppColors.accent,
//                     onChanged: _toggle2FA,
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Verification Methods
//               if (_is2FAEnabled)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: AppColors.card,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text("Verification Method",
//                               style: AppTextStyles.cardTitle),
//                         ),
//                         RadioListTile<String>(
//                           title: const Text("Authenticator App"),
//                           value: "Authenticator App",
//                           groupValue: _selectedMethod,
//                           activeColor: AppColors.accent,
//                           onChanged: (val) =>
//                               setState(() => _selectedMethod = val!),
//                         ),
//                         RadioListTile<String>(
//                           title: const Text("SMS"),
//                           value: "SMS",
//                           groupValue: _selectedMethod,
//                           activeColor: AppColors.accent,
//                           onChanged: (val) =>
//                               setState(() => _selectedMethod = val!),
//                         ),
//                         RadioListTile<String>(
//                           title: const Text("Email"),
//                           value: "Email",
//                           groupValue: _selectedMethod,
//                           activeColor: const Color.fromARGB(255, 247, 218, 194),
//                           onChanged: (val) =>
//                               setState(() => _selectedMethod = val!),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//               const Spacer(),

//               // Save Button
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _saveSettings,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.accent,
//                       foregroundColor: Colors.black,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text("Save Settings",style: TextStyle(fontWeight: FontWeight.bold),),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
