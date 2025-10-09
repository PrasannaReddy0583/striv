import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/entites/investments_entites.dart';
import 'package:striv/pages/notifications.dart';
import 'package:striv/pages/settings/settings_screen.dart';
import 'package:striv/utils/app_palette.dart';
import 'package:striv/widgets/investments_card_widget.dart';

class AppColors {
  static Color primary = Color(0xFFEFBA8F);
  static Color primaryDark = Color(0xFFEFBA8F);

  static Color background = Color(0xFFF8F7F6);
  static Color card = Color(0xFFFFFFFF);
  static Color softElev = Color(0xFFF5E8DC);

  static Color titleText = Color(0xFF000000);
  static Color mutedText = Color(0xFF757575);
  static Color accentText = Color(0xFF57493F);

  static Color progressBg = Color(0xFFF5E8DC);
  static Color progressFill = primary;

  static Color buttonBg = primary;
  static Color outline = Color(0xFFF5E8DC);
}

double scale(BuildContext context, double size) {
  double baseWidth = 390;
  double screenWidth = MediaQuery.of(context).size.width;
  return size * (screenWidth / baseWidth);
}

// Model for Entrepreneur/Investor matches
class EntrepreneurMatch {
  final String id;
  final String name;
  final String role;
  final String avatarUrl;

  EntrepreneurMatch({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarUrl,
  });

  factory EntrepreneurMatch.fromJson(Map<String, dynamic> json) {
    return EntrepreneurMatch(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }
}

// Model for User Profile
class UserProfile {
  final String name;
  final String avatarUrl;

  UserProfile({required this.name, required this.avatarUrl});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['name'] ?? 'User',
      avatarUrl: json['avatarUrl'] ?? 'https://i.pravatar.cc/300?img=47',
    );
  }
}

class InvestorHomePage extends StatefulWidget {
  final bool isInvestor;

  const InvestorHomePage({super.key, required this.isInvestor});

  @override
  State<InvestorHomePage> createState() => _InvestorHomePageState();
}

class _InvestorHomePageState extends State<InvestorHomePage> {
  // State variables
  late Future<UserProfile> _userProfileFuture;
  late Future<List<InvestmentsEntites>> _investmentsFuture;
  late Future<List<EntrepreneurMatch>> _entrepreneurMatchesFuture;

  // String _searchQuery = '';
  // bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _userProfileFuture = _fetchUserProfile();
    _investmentsFuture = _fetchInvestments();
    _entrepreneurMatchesFuture = _fetchEntrepreneurMatches();
  }

  // TODO: Replace with actual API calls
  Future<UserProfile> _fetchUserProfile() async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 500));
    return UserProfile(
      name: 'Alex',
      avatarUrl: 'https://i.pravatar.cc/300?img=47',
    );
  }

  Future<List<InvestmentsEntites>> _fetchInvestments() async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 800));
    return [
      InvestmentsEntites(
        investorid: "1",
        title: "EcoBloom",
        subtitle: "Sustainable Consumer Goods",
        progress: 0.5,
        investors: 12,
        views: 250,
        feedback: 5,
      ),
      InvestmentsEntites(
        investorid: '2',
        title: "GreenTech",
        subtitle: "Clean Energy Solutions",
        progress: 0.7,
        investors: 18,
        views: 300,
        feedback: 7,
      ),
    ];
  }

  Future<List<EntrepreneurMatch>> _fetchEntrepreneurMatches() async {
    // Simulate API call
    await Future.delayed(Duration(milliseconds: 600));
    return [
      EntrepreneurMatch(
        id: '1',
        name: 'Ethan Carter',
        role: 'Tech, Early Stage',
        avatarUrl: 'https://i.pravatar.cc/150?img=12',
      ),
      EntrepreneurMatch(
        id: '2',
        name: 'Sophia Bennett',
        role: 'Sustainability, Seed',
        avatarUrl: 'https://i.pravatar.cc/150?img=8',
      ),
      EntrepreneurMatch(
        id: '3',
        name: 'Maya Patel',
        role: 'Growth, Series A',
        avatarUrl: 'https://i.pravatar.cc/150?img=34',
      ),
    ];
  }

  void _onSearchChanged(String query) {
    setState(() {
      // _searchQuery = query;
      // _isSearching = query.isNotEmpty;
    });
    // TODO: Implement search functionality
    // You might want to debounce this to avoid too many API calls
  }

  void _refreshData() {
    setState(() {
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFDF5EC), Color(0xFFF5E7DA)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: RefreshIndicator(
          onRefresh: () async {
            _refreshData();
            // Wait for all futures to complete
            await Future.wait([
              _userProfileFuture,
              _investmentsFuture,
              _entrepreneurMatchesFuture,
            ]);
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                surfaceTintColor: AppPalette.transparent,
                floating: true,
                snap: true,
                backgroundColor: Color(0xFFFDF5EC),
                pinned: false,
                expandedHeight: scale(context, 65),
                flexibleSpace: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 10,
                    bottom: 2,
                  ),
                ),
                title: FutureBuilder<UserProfile>(
                  future: _userProfileFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return HeaderSectionSkeleton();
                    }
                    if (snapshot.hasError || !snapshot.hasData) {
                      return HeaderSection(
                        userName: 'User',
                        avatarUrl: 'https://i.pravatar.cc/300?img=47',
                      );
                    }
                    return HeaderSection(
                      userName: snapshot.data!.name,
                      avatarUrl: snapshot.data!.avatarUrl,
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: scale(context, 16),
                    vertical: scale(context, 8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: scale(context, 16),
                    children: [
                      TextField(
                        cursorColor: AppPalette.black,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          hintText: "Search for Entrepreneurs",
                          hintStyle: TextStyle(color: AppPalette.black),
                          prefixIcon: Icon(
                            CupertinoIcons.search,
                            color: AppPalette.black,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      FutureBuilder<List<InvestmentsEntites>>(
                        future: _investmentsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return InvestmentsListSectionSkeleton();
                          }
                          if (snapshot.hasError) {
                            return ErrorWidget.withDetails(
                              message: 'Failed to load investments',
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return EmptyInvestmentsSection();
                          }
                          return InvestmentsListSection(
                            investments: snapshot.data!,
                            onViewAll: () {
                              // TODO: Navigate to full investments list
                            },
                          );
                        },
                      ),
                      FutureBuilder<List<EntrepreneurMatch>>(
                        future: _entrepreneurMatchesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return NewInvestorSectionSkeleton();
                          }
                          if (snapshot.hasError) {
                            return ErrorWidget.withDetails(
                              message: 'Failed to load matches',
                            );
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return EmptyMatchesSection();
                          }
                          return NewInvestorSection(
                            entrepreneurs: snapshot.data!,
                            onConnect: (entrepreneurId) {
                              // TODO: Implement connect functionality
                            },
                            onDismiss: (entrepreneurId) {
                              // TODO: Implement dismiss functionality
                              setState(() {
                                _entrepreneurMatchesFuture =
                                    _entrepreneurMatchesFuture.then(
                                      (matches) => matches
                                          .where((m) => m.id != entrepreneurId)
                                          .toList(),
                                    );
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String userName;
  final String avatarUrl;

  const HeaderSection({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: scale(context, 26),
          backgroundImage: NetworkImage(avatarUrl),
          backgroundColor: AppColors.softElev,
        ),
        SizedBox(width: scale(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, $userName!',
                style: TextStyle(
                  fontSize: scale(context, 18),
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleText,
                ),
              ),
              SizedBox(height: scale(context, 4)),
              Text(
                "${getGreeting()} 👋",
                style: TextStyle(
                  fontSize: scale(context, 18),
                  fontWeight: FontWeight.w600,
                  color: AppColors.titleText,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
              icon: Icon(CupertinoIcons.bell, size: 30),
              color: AppPalette.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              icon: Icon(CupertinoIcons.settings, size: 30),
              color: AppPalette.black,
            ),
          ],
        ),
      ],
    );
  }
}

class HeaderSectionSkeleton extends StatelessWidget {
  const HeaderSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: scale(context, 26),
          backgroundColor: AppColors.softElev,
        ),
        SizedBox(width: scale(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.softElev,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              SizedBox(height: scale(context, 4)),
              Container(
                width: 120,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.softElev,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InvestmentsListSection extends StatelessWidget {
  final List<InvestmentsEntites> investments;
  final VoidCallback? onViewAll;

  const InvestmentsListSection({
    super.key,
    required this.investments,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Investments',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: scale(context, 16),
                color: AppColors.titleText,
              ),
            ),
            if (investments.length > 2)
              TextButton(
                onPressed: onViewAll,
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: scale(context, 6)),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: investments.length,
            itemBuilder: (context, index) {
              return InvestmentsCardWidget(investments: investments[index]);
            },
          ),
        ),
      ],
    );
  }
}

class InvestmentsListSectionSkeleton extends StatelessWidget {
  const InvestmentsListSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 150,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.softElev,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: scale(context, 12)),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                width: 200,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: AppColors.softElev,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EmptyInvestmentsSection extends StatelessWidget {
  const EmptyInvestmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(scale(context, 24)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(scale(context, 12)),
      ),
      child: Column(
        children: [
          Icon(CupertinoIcons.briefcase, size: 48, color: AppColors.mutedText),
          SizedBox(height: scale(context, 12)),
          Text(
            'No investments yet',
            style: TextStyle(
              fontSize: scale(context, 16),
              fontWeight: FontWeight.w600,
              color: AppColors.titleText,
            ),
          ),
          SizedBox(height: scale(context, 4)),
          Text(
            'Start exploring entrepreneurs',
            style: TextStyle(
              fontSize: scale(context, 14),
              color: AppColors.mutedText,
            ),
          ),
        ],
      ),
    );
  }
}

class NewInvestorSection extends StatelessWidget {
  final List<EntrepreneurMatch> entrepreneurs;
  final Function(String)? onConnect;
  final Function(String)? onDismiss;

  const NewInvestorSection({
    super.key,
    required this.entrepreneurs,
    this.onConnect,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Entrepreneur Smart Matching',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: scale(context, 16),
            color: AppColors.titleText,
          ),
        ),
        SizedBox(height: scale(context, 12)),
        SizedBox(
          height: scale(context, 180),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: entrepreneurs.length,
            separatorBuilder: (_, __) => SizedBox(width: scale(context, 12)),
            itemBuilder: (context, idx) {
              final entrepreneur = entrepreneurs[idx];
              return EntrepreneurHomeMatchsSuggestionTile(
                name: entrepreneur.name,
                role: entrepreneur.role,
                avatarUrl: entrepreneur.avatarUrl,
                width: MediaQuery.of(context).size.width * 0.42,
                onConnect: () => onConnect?.call(entrepreneur.id),
                onDismiss: () => onDismiss?.call(entrepreneur.id),
              );
            },
          ),
        ),
      ],
    );
  }
}

class NewInvestorSectionSkeleton extends StatelessWidget {
  const NewInvestorSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.softElev,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: scale(context, 12)),
        SizedBox(
          height: scale(context, 180),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.42,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: AppColors.softElev,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EmptyMatchesSection extends StatelessWidget {
  const EmptyMatchesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(scale(context, 24)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(scale(context, 12)),
      ),
      child: Column(
        children: [
          Icon(CupertinoIcons.person_2, size: 48, color: AppColors.mutedText),
          SizedBox(height: scale(context, 12)),
          Text(
            'No matches available',
            style: TextStyle(
              fontSize: scale(context, 16),
              fontWeight: FontWeight.w600,
              color: AppColors.titleText,
            ),
          ),
          SizedBox(height: scale(context, 4)),
          Text(
            'Check back later for new matches',
            style: TextStyle(
              fontSize: scale(context, 14),
              color: AppColors.mutedText,
            ),
          ),
        ],
      ),
    );
  }
}

class EntrepreneurHomeMatchsSuggestionTile extends StatelessWidget {
  final String name;
  final String role;
  final String avatarUrl;
  final double width;
  final VoidCallback? onConnect;
  final VoidCallback? onDismiss;

  const EntrepreneurHomeMatchsSuggestionTile({
    super.key,
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.width,
    this.onConnect,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        horizontal: scale(context, 12),
        vertical: scale(context, 14),
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(scale(context, 14)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: scale(context, 8),
            offset: Offset(0, scale(context, 4)),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: onDismiss,
                child: Icon(CupertinoIcons.clear, size: 11),
              ),
            ],
          ),
          CircleAvatar(
            radius: scale(context, 28),
            backgroundImage: NetworkImage(avatarUrl),
            backgroundColor: AppColors.softElev,
          ),
          SizedBox(height: scale(context, 8)),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: scale(context, 13),
              color: AppColors.titleText,
            ),
          ),
          SizedBox(height: scale(context, 2)),
          Text(
            role,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: scale(context, 11),
              color: AppColors.mutedText,
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            height: scale(context, 32),
            child: OutlinedButton(
              onPressed: onConnect,
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.background,
                side: BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(scale(context, 10)),
                ),
                padding: EdgeInsets.symmetric(vertical: scale(context, 6)),
              ),
              child: Text(
                'Connect',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: scale(context, 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String getGreeting() {
  final now = DateTime.now();
  final hour = now.hour;
  final minute = now.minute;

  if (hour < 12 || (hour == 11 && minute <= 59)) {
    return "Good Morning";
  } else if ((hour == 12 || hour < 15) || (hour == 15 && minute <= 30)) {
    return "Good Afternoon";
  } else if ((hour > 15 && hour < 20) ||
      (hour == 15 && minute > 30) ||
      (hour == 20 && minute <= 30)) {
    return "Good Evening";
  } else {
    return "Good Night";
  }
}
