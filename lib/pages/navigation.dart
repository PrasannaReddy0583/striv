import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:striv/pages/chats/chats_contacts_page.dart';
import 'package:striv/pages/community/community_screen.dart';
import 'package:striv/pages/entrepreneur/home_page.dart';
import 'package:striv/pages/entrepreneur/pitch_upload2/pitch_problem_step1.dart';
import 'package:striv/pages/investor/discover_page.dart';
import 'package:striv/pages/investor/investor_home_page.dart';
import 'package:striv/pages/investor/requests_page.dart';
import 'package:striv/utils/app_palette.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0; // Default to "Home"
  static bool get isInvestor => getRoleInvestor();

  final List<Widget> _pages = [
    isInvestor
        ? InvestorHomePage(isInvestor: isInvestor)
        : HomePage(isInvestor: isInvestor),
    isInvestor
        ? DiscoverPage(isInvestor: isInvestor)
        : DiscoverPage(isInvestor: isInvestor),
    isInvestor ? RequestsPage(isInvestor: isInvestor) : SizedBox(),
    isInvestor
        ? ChatsContactsPage(isInvestor: isInvestor)
        : ChatsContactsPage(isInvestor: isInvestor),
    isInvestor
        ? CommunityHomeScreen(isInvestor: isInvestor)
        : CommunityHomeScreen(isInvestor: isInvestor),
  ];

  void _onItemTapped(int index) {
    if (!isInvestor && index == 2) {
      // Entrepreneur's Upload tab
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProblemSolutionForm()),
      );
    } else {
      // Normal navigation
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppPalette.background,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppPalette.primaryBackground,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppPalette.background,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.compass),
              label: "Discover",
            ),
            isInvestor
                ? BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.download_circle),
                    label: "Requests",
                  )
                : BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.paperplane),
                    label: "Upload",
                  ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: "Chats",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.group),
              label: "Circle",
            ),
          ],
        ),
      ),
    );
  }
}

bool getRoleInvestor() {
  return false;
}
