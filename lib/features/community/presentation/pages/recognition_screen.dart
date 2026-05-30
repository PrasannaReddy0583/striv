import 'package:flutter/material.dart';

class RecognitionScreen extends StatelessWidget {
  const RecognitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFDF5EC), // light warm
              Color(0xFFF5E7DA), // slightly darker
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // AppBar replacement (since we have gradient)
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF57493F),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Navigate back
                      },
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Recognition",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF57493F),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 48),
                  ],
                ),
                SizedBox(height: 24),

                // Profile section
                Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Ethan Carter",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF57493F),
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.verified,
                          color: Color(0xFFFF6F3C),
                          size: 18,
                        ),
                      ],
                    ),
                    Text(
                      "Entrepreneur",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF6F3C).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "250",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFF6F3C),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Contribution Points",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24),

                // Badges Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Badges",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF57493F),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBadge("assets/badge1.png", "Investor of the Month"),
                    _buildBadge("assets/badge2.png", "Top Contributor"),
                    _buildBadge("assets/badge3.png", "Community Builder"),
                  ],
                ),

                SizedBox(height: 24),

                // Leaderboard Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Leaderboards",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF57493F),
                    ),
                  ),
                ),
                SizedBox(height: 12),

                // Tabs
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Color(0xFFFF6F3C),
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: Color(0xFFFF6F3C),
                        tabs: [
                          Tab(text: "Weekly"),
                          Tab(text: "Monthly"),
                          Tab(text: "All Time"),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                        child: TabBarView(
                          children: [
                            _buildLeaderboard(),
                            _buildLeaderboard(),
                            _buildLeaderboard(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Badge Widget
  static Widget _buildBadge(String asset, String title) {
    return Column(
      children: [
        CircleAvatar(radius: 30, backgroundImage: AssetImage(asset)),
        SizedBox(height: 6),
        SizedBox(
          width: 80,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Color(0xFF57493F)),
          ),
        ),
      ],
    );
  }

  // Leaderboard Widget
  static Widget _buildLeaderboard() {
    final leaders = [
      {
        "name": "Liam Bennett",
        "points": "230 points",
        "rank": "1",
        "image": "assets/user1.png",
      },
      {
        "name": "Olivia Hayes",
        "points": "215 points",
        "rank": "2",
        "image": "assets/user2.png",
      },
      {
        "name": "Noah Parker",
        "points": "200 points",
        "rank": "3",
        "image": "assets/user3.png",
      },
    ];

    return ListView.builder(
      itemCount: leaders.length,
      itemBuilder: (context, index) {
        final leader = leaders[index];
        return ListTile(
          leading: CircleAvatar(backgroundImage: AssetImage(leader["image"]!)),
          title: Text(
            leader["name"]!,
            style: TextStyle(color: Color(0xFF57493F)),
          ),
          subtitle: Text(
            leader["points"]!,
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Text(
            leader["rank"]!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFFFF6F3C),
            ),
          ),
        );
      },
    );
  }
}
