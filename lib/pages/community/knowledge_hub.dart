import 'package:flutter/material.dart';

class KnowledgeItem {
  final String type;
  final String title;
  final String description;
  final String imageUrl;
  final String duration;

  KnowledgeItem({
    required this.type,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.duration,
  });
}

class KnowledgeHubScreen extends StatefulWidget {
  const KnowledgeHubScreen({super.key});

  @override
  State<KnowledgeHubScreen> createState() => _KnowledgeHubScreenState();
}

class _KnowledgeHubScreenState extends State<KnowledgeHubScreen> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  final List<KnowledgeItem> knowledgeItems = [
    KnowledgeItem(
      type: "Article",
      title: "Mastering the Art of Pitching to Investors",
      description:
          "Learn how to craft a compelling pitch that resonates with investors and secures funding for your startup.",
      imageUrl: "https://picsum.photos/400/200?random=1",
      duration: "5 min read",
    ),
    KnowledgeItem(
      type: "Video",
      title: "Scaling Your Business: Strategies for Sustainable Growth",
      description:
          "Explore proven strategies for scaling your business while maintaining quality and customer satisfaction.",
      imageUrl: "https://picsum.photos/400/200?random=2",
      duration: "12 min video",
    ),
    KnowledgeItem(
      type: "Guide",
      title: "Legal Essentials for Startups: Protecting Your IP",
      description:
          "Understand the key legal considerations for startups, including how to protect your intellectual property.",
      imageUrl: "https://picsum.photos/400/200?random=3",
      duration: "8 min read",
    ),
  ];

  final categories = ["All", "Article", "Video", "Guide", "Case Study"];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDF5EC), Color(0xFFF5E7DA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Color(0xFF57493F)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      "Knowledge Hub",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF57493F),
                      ),
                    ),
                    SizedBox(width: 48), // placeholder for symmetry
                  ],
                ),
              ),

              // Search Box
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: "Search articles, guides, and videos",
                    prefixIcon: Icon(Icons.search, color: Color(0xFFEFBA8F)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // TabBar
              TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Color(0xFFFF6F3C),
                unselectedLabelColor: Colors.black,
                indicatorColor: Color(0xFFFFD166),
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.only(left: 4, right: 16),
                tabs: categories.map((c) => Tab(text: c)).toList(),
              ),

              // TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: categories.map((category) {
                    final filteredItems = knowledgeItems.where((item) {
                      final matchesCategory = category == "All" || item.type == category;
                      final matchesSearch = _searchController.text.isEmpty ||
                          item.title.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                          item.description.toLowerCase().contains(_searchController.text.toLowerCase());
                      return matchesCategory && matchesSearch;
                    }).toList();

                    return filteredItems.isEmpty
                        ? Center(child: Text("No items found"))
                        : ListView.builder(
                            padding: EdgeInsets.all(8),
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) => _buildKnowledgeCard(filteredItems[index]),
                          );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKnowledgeCard(KnowledgeItem item) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF5E7DA),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
            child: Image.network(
              item.imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.type,
                    style: TextStyle(color: Color(0xFFEFBA8F), fontWeight: FontWeight.bold, fontSize: 12)),
                SizedBox(height: 4),
                Text(item.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.duration, style: TextStyle(color: Colors.grey)),
                    Row(
                      children: [
                        Icon(Icons.bookmark_border, color: Color(0xFFEFBA8F)),
                        SizedBox(width: 8),
                        Icon(Icons.share, color: Color(0xFFEFBA8F)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
