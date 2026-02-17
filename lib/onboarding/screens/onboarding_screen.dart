import 'package:flutter/material.dart';
import 'package:striv/core/widgets/core_slider.dart';

class OnboardingScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final bool isLastPage;
  final bool isFirstPage;
  final VoidCallback onNext;
  final VoidCallback onPrev;

  const OnboardingScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.isLastPage,
    required this.isFirstPage,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      letterSpacing: 1.2,
                      height: 1.3,
                      fontFamily: 'Revalia',
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Colors.black54,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.only(bottom: isFirstPage ? 100 : 0),
            child: SlideButton(
              text: isLastPage ? "Get started" : "Next",
              onSlideComplete: onNext,
            ),
          ),
          if (!isFirstPage)
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 56),
              child: GestureDetector(
                onTap: onPrev,
                child: const Text(
                  "Previous",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
