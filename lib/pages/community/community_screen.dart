import 'package:flutter/material.dart';
import 'package:striv/pages/community/discuss_screen.dart';
import 'package:striv/pages/community/knowledge_hub.dart';
import 'package:striv/pages/community/network_screen.dart';
import 'package:striv/pages/community/recognition_screen.dart';

class CommunityHomeScreen extends StatelessWidget {
  const CommunityHomeScreen({super.key, required isInvestor});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {"title": "Discuss", "icon": Icons.forum, "color": Color(0xFFEFBA8F)},
      {
        "title": "Knowledge Hub",
        "icon": Icons.menu_book,
        "color": Color(0xFFEFBA8F),
      },
      {"title": "Networking", "icon": Icons.people, "color": Color(0xFFEFBA8F)},
      {
        "title": "Recognition",
        "icon": Icons.folder,
        "color": Color(0xFFEFBA8F),
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting
              Text(
                "Hello, Ethan 👋",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Explore your community today",
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),

              SizedBox(height: 20),

              // Quick stats
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(title: "Members", value: "1.2K"),
                    _StatItem(title: "Posts Today", value: "45"),
                    _StatItem(title: "New Resources", value: "8"),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // Community Features Grid
              Expanded(
                child: GridView.builder(
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        final title = category["title"] as String;
                        Widget page;
                        if (title == "Knowledge Hub") {
                          page = KnowledgeHubScreen();
                        } else if (title == "Networking") {
                          page = NetworkingScreen();
                        } else if (title == "Recognition") {
                          page = RecognitionScreen();
                        } else {
                          page = DiscussScreen(category: title);
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => page),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: (category["color"] as Color)
                                  .withOpacity(0.2),
                              child: Icon(
                                category["icon"] as IconData,
                                size: 30,
                                color: category["color"] as Color,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              category["title"] as String,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Text(title, style: TextStyle(fontSize: 12, color: Colors.black54)),
      ],
    );
  }
}
