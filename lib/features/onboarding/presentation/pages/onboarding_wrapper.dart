import 'package:flutter/material.dart';
import 'package:striv/features/auth/presentation/pages/login_screen.dart';
import 'package:striv/core/constants.dart';
import 'onboarding_screen.dart';
import '../widgets/onboarding_indicator.dart';

class OnboardingWrapper extends StatefulWidget {
  const OnboardingWrapper({super.key});

  @override
  State<OnboardingWrapper> createState() => _OnboardingWrapperState();
}

class _OnboardingWrapperState extends State<OnboardingWrapper> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Join the Network",
      "subtitle":
          "Unlock entrepreneurial opportunity and investment connections.",
      "image": AssetPaths.onboarding1,
    },
    {
      "title": "Invest with Confidence",
      "subtitle": "Find startups, track deals, and safely review pitches.",
      "image": AssetPaths.onboarding2,
    },
    {
      "title": "Pitch, Fund and Learn",
      "subtitle":
          "Entrepreneurs can pitch ideas, get funded, and learn from experts.",
      "image": AssetPaths.onboarding3,
    },
  ];

  void _onSkipOrFinish() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _onNext() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: DurationsClass.pageTransition,
        curve: Curves.easeInOutCubic,
      );
    } else {
      _onSkipOrFinish();
    }
  }

  void _onPrev() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: DurationsClass.pageTransition,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return OnboardingScreen(
                title: data["title"]!,
                subtitle: data["subtitle"]!,
                imagePath: data["image"]!,
                isLastPage: index == onboardingData.length - 1,
                isFirstPage: index == 0,
                onNext: _onNext,
                onPrev: _onPrev,
              );
            },
          ),

          OnboardingIndicator(
            currentPage: _currentPage,
            totalPages: onboardingData.length,
            onSkip: _onSkipOrFinish,
            skipTextStyle: AppTextStyles.skipText,
            dotActiveColor: AppColors.black,
            dotInactiveColor: AppColors.inactive,
          ),
        ],
      ),
    );
  }
}
