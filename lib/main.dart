import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:striv/onboarding/splash/splash.dart';
import 'package:striv/utils/app_palette.dart';

// Testing changes
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(
    (kIsWeb || Platform.isWindows || Platform.isLinux || Platform.isMacOS)
        ? DevicePreview(enabled: true, builder: (context) => const StrivApp())
        : const StrivApp(),
  );
}

class StrivApp extends StatelessWidget {
  const StrivApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dealence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        scaffoldBackgroundColor: AppPalette.primaryBackground,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.grey,
          selectionHandleColor: Colors.black,
        ),
        useMaterial3: false,
      ),
      home: GradientScaffold(child: SplashScreen()),
    );
  }
}

class GradientScaffold extends StatelessWidget {
  final Widget child;
  const GradientScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromARGB(255, 211, 161, 178), Colors.white],
        ),
      ),
      child: Scaffold(backgroundColor: Colors.transparent, body: child),
    );
  }
}
