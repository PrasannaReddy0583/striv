import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:striv/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:striv/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:striv/features/community/presentation/cubit/community_cubit.dart';
import 'package:striv/features/discover/presentation/bloc/discover_bloc.dart';
import 'package:striv/features/home/presentation/bloc/home_bloc.dart';
import 'package:striv/features/navigation/cubit/navigation_cubit.dart';
import 'package:striv/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:striv/features/pitch/presentation/bloc/pitch_upload_bloc.dart';
import 'package:striv/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:striv/injection_container.dart';
import 'package:striv/navigation.dart';
import 'package:striv/utils/app_palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
        BlocProvider<NavigationCubit>(create: (_) => sl<NavigationCubit>()),
        BlocProvider<HomeBloc>(create: (_) => sl<HomeBloc>()),
        BlocProvider<DiscoverBloc>(create: (_) => sl<DiscoverBloc>()),
        BlocProvider<ChatBloc>(create: (_) => sl<ChatBloc>()),
        BlocProvider<NotificationsBloc>(
            create: (_) => sl<NotificationsBloc>()),
        BlocProvider<CommunityCubit>(create: (_) => sl<CommunityCubit>()),
        BlocProvider<SettingsCubit>(create: (_) => sl<SettingsCubit>()),
        BlocProvider<PitchUploadBloc>(create: (_) => sl<PitchUploadBloc>()),
      ],
      child: MaterialApp(
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
        home: const Navigation(),
      ),
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
