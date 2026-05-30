import 'package:flutter/material.dart';

class OnboardingIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;
  final TextStyle skipTextStyle;
  final Color dotActiveColor;
  final Color dotInactiveColor;

  const OnboardingIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onSkip,
    this.skipTextStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    this.dotActiveColor = Colors.black,
    this.dotInactiveColor = Colors.black26,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: List.generate(
              totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(right: 6),
                width: currentPage == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentPage == index
                      ? dotActiveColor
                      : dotInactiveColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          if (currentPage < totalPages - 1)
            GestureDetector(
              onTap: onSkip,
              child: Text("Skip", style: skipTextStyle),
            ),
        ],
      ),
    );
  }
}
