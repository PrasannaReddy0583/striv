// Re-export theme so files that import constants.dart for AppColors/AppTextStyles
// continue to work without any import changes.
export 'package:striv/core/theme/app_colors.dart';
export 'package:striv/core/theme/app_text_styles.dart';

class AppConstants {
  static const String appName = "Dealence";
  static const String version = "1.0.0";
}

class ApiConstants {
  static const String baseUrl = "http://localhost:3000/api";
  static const String loginEndpoint = "/auth/login";
  static const String signupEndpoint = "/auth/signup";
  static const String postsEndpoint = "/posts";
  static const String projectsEndpoint = "/projects";
  static const String reelsEndpoint = "/reels";
  static const String chatsEndpoint = "/chats";
  static const String notificationsEndpoint = "/notifications";
}

class AssetPaths {
  static const String logo = "assets/images/dealence_logo.jpg";
  static const String onboarding1 = "assets/images/onboarding1.jpg";
  static const String onboarding2 = "assets/images/onboarding2.jpg";
  static const String onboarding3 = "assets/images/onboarding3.jpg";
  static const String splashbg = "assets/images/splash_bg.png";
}

class TextStrings {
  static const String loginTitle = "Welcome Back!";
  static const String loginSubTitle = "Log in to continue your journey";
  static const String signupTitle = "Join the Network!";
  static const String signupSubTitle = "Create your account in seconds";
  static const String terms = "By signing up, you agree to our ";

  static const String roleSelectionTitle = "What's Your Role?";
  static const String roleSelectionSubTitle = "Tell us what brings you to Dealence.";
  static const String entrepreneur = "I'm an Entrepreneur";
  static const String entrepreneurDesc = "Seeking funding for my innovative startup.";
  static const String investor = "I'm an Investor";
  static const String investorDesc = "Looking to find and fund promising ventures.";
}

class DurationsClass {
  static const Duration pageTransition = Duration(milliseconds: 400);
}
