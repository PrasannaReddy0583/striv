import 'package:flutter/material.dart';
import 'package:striv/core/constants.dart';
import 'package:striv/onboarding/screens/onboarding_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _backgroundFade;
  late Animation<double> _logoScale;
  late Animation<double> _splashFadeOut;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _backgroundFade = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _logoScale = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _splashFadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.9, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingWrapper()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _splashFadeOut.value,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Opacity(
                  opacity: _backgroundFade.value,
                  child: Image.asset(AssetPaths.splashbg, fit: BoxFit.cover),
                ),
                Center(
                  child: Transform.scale(
                    scale: _logoScale.value,
                    child: const Text(
                      "Dealence",
                      style: TextStyle(
                        fontFamily: "Revalia",
                        fontSize: 36,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
