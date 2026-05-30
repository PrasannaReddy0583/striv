import 'package:flutter/material.dart';

class NetworkingScreen extends StatefulWidget {
  const NetworkingScreen({super.key});

  @override
  State<NetworkingScreen> createState() => _NetworkingScreenState();
}

class _NetworkingScreenState extends State<NetworkingScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "All";

  final List<Map<String, dynamic>> yourCommunities = [
    {"title": "Tech Innovators", "image": "https://picsum.photos/200?1"},
    {"title": "Creative Minds", "image": "https://picsum.photos/200?2"},
    {"title": "Health Leaders", "image": "https://picsum.photos/200?3"},
  ];

  final List<Map<String, dynamic>> discoverCommunities = [
    {
      "title": "AI Enthusiasts",
      "members": "12k members",
      "category": "Tech",
      "image": "https://picsum.photos/200?4",
    },
    {
      "title": "Digital Marketing",
      "members": "8k members",
      "category": "Marketing",
      "image": "https://picsum.photos/200?5",
    },
    {
      "title": "Product Management",
      "members": "15k members",
      "category": "Design",
      "image": "https://picsum.photos/200?6",
    },
    {
      "title": "Frontend Devs",
      "members": "7k members",
      "category": "Tech",
      "image": "https://picsum.photos/200?7",
    },
  ];

  final List<String> filters = ["All", "Tech", "Design", "Marketing"];

  @override
  Widget build(BuildContext context) {
    final filteredCommunities =
        discoverCommunities.where((c) {
          if (_selectedFilter == "All") return true;
          return c["category"] == _selectedFilter;
        }).toList();

    return Scaffold(
      // Background gradient
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFDF5EC), Color(0xFFF5E7DA)],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              // AppBar replacement
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF57493F),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                  ),
                  Text(
                    "Communities",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF57493F),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFFFFD166),
                    child: IconButton(
                      icon: Icon(Icons.add, color: Color(0xFF57493F)),
                      onPressed: () {
                        // Add community action
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search communities",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF57493F),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Your Communities
              Text(
                "Your Communities",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF57493F),
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: yourCommunities.length,
                  itemBuilder: (context, index) {
                    final community = yourCommunities[index];
                    return Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              community["image"],
                              height: 70,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            community["title"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF57493F),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 24),

              // Discover Communities
              Text(
                "Discover Communities",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF57493F),
                ),
              ),
              SizedBox(height: 12),

              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      filters.map((f) {
                        final selected = f == _selectedFilter;
                        return Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              f,
                              style: TextStyle(
                                color:
                                    selected
                                        ? Colors.white
                                        : Color(0xFF57493F),
                              ),
                            ),
                            selected: selected,
                            selectedColor: Color(0xFFFF6F3C),
                            backgroundColor: Color(0xFFFFF3E0),
                            onSelected: (_) {
                              setState(() => _selectedFilter = f);
                            },
                          ),
                        );
                      }).toList(),
                ),
              ),
              SizedBox(height: 16),

              // Community Grid
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredCommunities.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 180,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final community = filteredCommunities[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.06),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(14),
                          ),
                          child: Image.network(
                            community["image"],
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                community["title"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF57493F),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                community["members"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
