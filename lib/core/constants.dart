import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = "Dealence";
  static const String version = "1.0.0";
}

class ApiConstants {
  // static const String baseUrl = "https:
  static const String loginEndpoint = "/auth/login";
  static const String signupEndpoint = "/auth/signup";
}

class AssetPaths {
  static const String logo = "assets/images/dealence_logo.jpg";
  static const String onboarding1 = "assets/images/onboarding1.jpg";
  static const String onboarding2 = "assets/images/onboarding2.jpg";
  static const String onboarding3 = "assets/images/onboarding3.jpg";
  static const String splashbg = "assets/images/splash_bg.png";
}

class TextStrings {
  // General
  static const String loginTitle = "Welcome Back!";
  static const String loginSubTitle = "Log in to continue your journey";
  static const String signupTitle = "Join the Network!";
  static const String signupSubTitle = "Create your account in seconds";
  static const String terms = "By signing up, you agree to our ";

  // Role Selection
  static const String roleSelectionTitle = "What's Your Role?";
  static const String roleSelectionSubTitle =
      "Tell us what brings you to Dealence.";
  static const String entrepreneur = "I'm an Entrepreneur";
  static const String entrepreneurDesc =
      "Seeking funding for my innovative startup.";
  static const String investor = "I'm an Investor";
  static const String investorDesc =
      "Looking to find and fund promising ventures.";
}

class AppColors {
  static const Color primary = Colors.black;
  static const Color inactive = Colors.black26;
  static const Color background = Colors.white;

  // Theme-specific Colors
  static const Color accent = Color(0xFFEAD2BD);
  static const Color card = Color(0xFFF8F3ED);
  static const Color gold = Color(0xFFEBCF00);
  static final Color softElev = const Color(0xFFF5E8DC);

  // Gradient Background for Role Selection
  static const Color backgroundTop = Color(0xFFFDFCFB);
  static const Color backgroundBottom = Color(0xFFF8F3ED);

  // Text Colors
  static const Color titleText = Color(0xFF000000);
  static const Color mutedText = Color(0xFF757575);
  static const Color accentText = Color(0xFF57493F);
  static const Color subtitle = Colors.black54;

  // Other UI Elements
  static const Color progressBg = Color(0xFFF5E8DC);
  static const Color progressFill = primary;
  static const Color buttonBg = primary;
  static const Color outline = Color(0xFFF5E8DC);
}

class AppTextStyles {
  // Onboarding
  static const TextStyle skipText = TextStyle(
    fontFamily: 'Revalia',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  // General Titles
  static const TextStyle title = TextStyle(
    letterSpacing: 1.2,
    height: 1.3,
    fontFamily: 'Revalia',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  );

  static const TextStyle pageTitle = TextStyle(
    fontFamily: 'Revalia',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: 'Revalia',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.accentText,
  );

  // General Body/Subtitle Text
  static const TextStyle subtitle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    color: Colors.black54,
    height: 1.6,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    color: AppColors.mutedText,
    height: 1.5,
  );
}

class DurationsClass {
  static const Duration pageTransition = Duration(milliseconds: 400);
}
