import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/features/navigation/cubit/navigation_cubit.dart';
import 'package:striv/features/navigation/cubit/navigation_state.dart';
import 'package:striv/features/chat/presentation/pages/chats_contacts_page.dart';
import 'package:striv/features/community/presentation/pages/community_screen.dart';
import 'package:striv/features/home/presentation/pages/entrepreneur_home_page.dart';
import 'package:striv/features/pitch/presentation/pages/upload/pitch_problem_step1.dart';
import 'package:striv/features/discover/presentation/pages/investor_discover_page.dart';
import 'package:striv/features/home/presentation/pages/investor_home_page.dart';
import 'package:striv/features/home/presentation/pages/requests_page.dart';
import 'package:striv/utils/app_palette.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  static bool get isInvestor => getRoleInvestor();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationCubit(),
      child: const _NavigationView(),
    );
  }
}

class _NavigationView extends StatelessWidget {
  const _NavigationView();

  static bool get isInvestor => getRoleInvestor();

  List<Widget> get _pages => [
        isInvestor
            ? InvestorHomePage(isInvestor: isInvestor)
            : HomePage(isInvestor: isInvestor),
        DiscoverPage(isInvestor: isInvestor),
        isInvestor ? RequestsPage(isInvestor: isInvestor) : const SizedBox(),
        ChatsContactsPage(isInvestor: isInvestor),
        CommunityHomeScreen(isInvestor: isInvestor),
      ];

  void _onItemTapped(BuildContext context, int index) {
    if (!isInvestor && index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProblemSolutionForm()),
      );
    } else {
      context.read<NavigationCubit>().navigateTo(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            systemNavigationBarColor: AppPalette.background,
            systemNavigationBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: AppPalette.primaryBackground,
            extendBody: true,
            resizeToAvoidBottomInset: false,
            body: _pages[state.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: AppPalette.background,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              currentIndex: state.selectedIndex,
              onTap: (index) => _onItemTapped(context, index),
              selectedItemColor: AppPalette.messageColor,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Home",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.compass),
                  label: "Discover",
                ),
                isInvestor
                    ? const BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.download_circle),
                        label: "Requests",
                      )
                    : const BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.paperplane),
                        label: "Upload",
                      ),
                const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble_2),
                  label: "Chats",
                ),
                const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.group),
                  label: "Circle",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

bool getRoleInvestor() {
  return false;
}
