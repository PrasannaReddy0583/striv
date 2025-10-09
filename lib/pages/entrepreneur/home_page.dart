import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/pages/notifications.dart';
import 'package:striv/pages/settings/settings_screen.dart';
import 'package:striv/utils/app_palette.dart';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key, required isInvestor});

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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              surfaceTintColor: AppPalette.transparent,
              floating: true,
              snap: true,
              // automaticallyImplyLeading: true,
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
              title: HeaderSection(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: scale(context, 16),
                  vertical: scale(context, 18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HeaderSection(),
                    // SizedBox(height: scale(context, 18)),
                    PitchListSection(),
                    SizedBox(height: scale(context, 20)),
                    NewInvestorSection(),
                    SizedBox(height: scale(context, 22)),
                    LearningAndGrowth(),
                    SizedBox(height: scale(context, 22)),
                    UpcomingDemoCard(),
                    SizedBox(height: scale(context, 30)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: scale(context, 26),
          backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=47'),
        ),
        SizedBox(width: scale(context, 12)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, Alex!',
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

class Pitch {
  final String title;
  final String subtitle;
  final double progress;
  final int investors;
  final int views;
  final int feedback;

  Pitch({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.investors,
    required this.views,
    required this.feedback,
  });
}

class PitchCard extends StatelessWidget {
  final Pitch pitch;
  const PitchCard({super.key, required this.pitch});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.only(right: scale(context, 16)),
      padding: EdgeInsets.all(scale(context, 16)),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(scale(context, 16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: scale(context, 12),
            offset: Offset(0, scale(context, 6)),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: scale(context, 56),
                height: scale(context, 56),
                decoration: BoxDecoration(
                  color: AppColors.softElev,
                  borderRadius: BorderRadius.circular(scale(context, 10)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('https://via.placeholder.com/64'),
                  ),
                ),
              ),
              SizedBox(width: scale(context, 12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pitch.title,
                      style: TextStyle(
                        fontSize: scale(context, 16),
                        fontWeight: FontWeight.w700,
                        color: AppColors.titleText,
                      ),
                    ),
                    SizedBox(height: scale(context, 4)),
                    Text(
                      pitch.subtitle,
                      style: TextStyle(
                        fontSize: scale(context, 12),
                        color: AppColors.mutedText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: scale(context, 14)),

          Row(
            children: [
              Expanded(
                child: Text(
                  'Funding Progress',
                  style: TextStyle(
                    fontSize: scale(context, 13),
                    fontWeight: FontWeight.w600,
                    color: AppColors.titleText,
                  ),
                ),
              ),
              Text(
                'Goal Reached',
                style: TextStyle(
                  fontSize: scale(context, 12),
                  color: AppColors.mutedText,
                ),
              ),
            ],
          ),

          SizedBox(height: scale(context, 8)),

          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(scale(context, 10)),
                  child: LinearProgressIndicator(
                    value: pitch.progress,
                    minHeight: scale(context, 10),
                    backgroundColor: AppColors.progressBg,
                    valueColor: AlwaysStoppedAnimation(AppColors.progressFill),
                  ),
                ),
              ),
              SizedBox(width: scale(context, 12)),
              Text(
                '${(pitch.progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: scale(context, 13),
                  fontWeight: FontWeight.w700,
                  color: AppColors.titleText,
                ),
              ),
            ],
          ),

          SizedBox(height: scale(context, 14)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StatColumn(
                number: pitch.investors.toString(),
                label: 'Investors',
              ),
              StatColumn(number: pitch.views.toString(), label: 'Pitch Views'),
              StatColumn(number: pitch.feedback.toString(), label: 'Feedback'),
            ],
          ),

          SizedBox(height: scale(context, 16)),

          SizedBox(
            width: double.infinity,
            height: scale(context, 44),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(scale(context, 12)),
                ),
                elevation: 0,
              ),
              child: Text(
                'View Pitch Analytics',
                style: TextStyle(
                  color: AppPalette.white,
                  fontSize: scale(context, 15),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PitchListSection extends StatelessWidget {
  const PitchListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Pitch> pitches = [
      Pitch(
        title: "EcoBloom",
        subtitle: "Sustainable Consumer Goods",
        progress: 0.5,
        investors: 12,
        views: 250,
        feedback: 5,
      ),
      Pitch(
        title: "GreenTech",
        subtitle: "Clean Energy Solutions",
        progress: 0.7,
        investors: 18,
        views: 300,
        feedback: 7,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'My Pitches',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: scale(context, 16),
                color: AppColors.titleText,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Navigate to full list screen
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: scale(context, 12)),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: pitches.length,
            itemBuilder: (context, index) {
              return PitchCard(pitch: pitches[index]);
            },
          ),
        ),
        // SizedBox(height: 10),
      ],
    );
  }
}

/// Investors Section (fixed overflow issue)
class NewInvestorSection extends StatelessWidget {
  const NewInvestorSection({super.key});

  @override
  Widget build(BuildContext context) {
    final investors = [
      {
        'name': 'Ethan Carter',
        'role': 'Tech, Early Stage',
        'avatar': 'https://i.pravatar.cc/150?img=12',
      },
      {
        'name': 'Sophia Bennett',
        'role': 'Sustainability, Seed',
        'avatar': 'https://i.pravatar.cc/150?img=8',
      },
      {
        'name': 'Maya Patel',
        'role': 'Growth, Series A',
        'avatar': 'https://i.pravatar.cc/150?img=34',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Investor Connections',
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
            itemCount: investors.length,
            separatorBuilder: (_, __) => SizedBox(width: scale(context, 12)),
            itemBuilder: (context, idx) {
              final inv = investors[idx];
              return InvestorCard(
                name: inv['name']!,
                role: inv['role']!,
                avatarUrl: inv['avatar']!,
                width: MediaQuery.of(context).size.width * 0.42,
              );
            },
          ),
        ),
      ],
    );
  }
}

class InvestorCard extends StatelessWidget {
  final String name;
  final String role;
  final String avatarUrl;
  final double width;

  const InvestorCard({
    super.key,
    required this.name,
    required this.role,
    required this.avatarUrl,
    required this.width,
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
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.background,
                side: BorderSide(color: AppColors.outline),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(scale(context, 10)),
                ),
                padding: EdgeInsets.symmetric(vertical: scale(context, 6)),
              ),
              child: Text(
                'Connect',
                style: TextStyle(
                  color: AppColors.primary,
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

class UpcomingDemoCard extends StatelessWidget {
  const UpcomingDemoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left text column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Upcoming Demo Day',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColors.titleText,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Showcase your startup to top investors.',
                  style: TextStyle(fontSize: 12, color: AppColors.mutedText),
                ),
                SizedBox(height: 8),
                Text(
                  'View Details',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Right thumbnail
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/80'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LearningAndGrowth extends StatelessWidget {
  const LearningAndGrowth({super.key});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      {'title': 'Pitch Guide', 'icon': Icons.book},
      {'title': 'Templates', 'icon': Icons.description_outlined},
      {'title': 'Legal', 'icon': Icons.gavel_outlined},
      {'title': 'Scaling', 'icon': Icons.trending_up_outlined},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Learning & Growth',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.titleText,
          ),
        ),
        SizedBox(height: 12),
        GridView.builder(
          itemCount: tiles.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 84,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, idx) {
            final t = tiles[idx];
            return FeatureTile(
              title: t['title'] as String,
              icon: t['icon'] as IconData,
            );
          },
        ),
      ],
    );
  }
}

class FeatureTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const FeatureTile({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.softElev,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.titleText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatColumn extends StatelessWidget {
  final String number;
  final String label;
  const StatColumn({super.key, required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.titleText,
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 11, color: AppColors.mutedText)),
      ],
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
