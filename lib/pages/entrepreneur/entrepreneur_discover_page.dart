import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:striv/pages/search_filters_page.dart';
import 'package:striv/utils/app_palette.dart';
import 'package:striv/widgets/post_widget.dart';
import 'package:striv/widgets/reels_widget.dart';
import 'package:striv/widgets/swipable_cards_widget.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key, required this.isInvestor});
  final bool isInvestor;

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  final List<String> filterTabs = ['Projects', 'Posts', 'Reels'];

  final sampleReels = [
    {
      "videoUrl":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      "caption": "Check out this amazing animation!",
      "ownerFullName": "Blender Foundation",
      "ownerUsername": "blender",
    },
    {
      "videoUrl":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
      "caption": "Sintel short film clip",
      "ownerFullName": "Blender Studio",
      "ownerUsername": "blenderstudio",
    },
  ];

  List<Map<String, dynamic>> feedItems = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: filterTabs.length, vsync: this);
    // 👇 Rebuild whenever tab index changes
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
    fetchFeedItems();
  }

  Future<void> fetchFeedItems() async {
    try {
      final response = await http.get(
        Uri.parse("https://dummyjson.com/posts?limit=10"),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          feedItems = (data['posts'] as List).map((post) {
            return {
              "type": "post",
              "username": "user_${post['userId']}",
              "imageUrl": "https://picsum.photos/400/300?random=${post['id']}",
              "caption": post['body'],
            };
          }).toList();

          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching posts: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerScrolled) {
          return [
            SliverAppBar(
              surfaceTintColor: Colors.transparent,
              title: const Text(
                "Discover",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppPalette.textPrimary,
                ),
              ),
              floating: _tabController.index != 0 ? true : false,
              snap: _tabController.index != 0 ? true : false,
              pinned: _tabController.index != 0
                  ? false
                  : true, // 👈 keeps tabs visible
              backgroundColor: AppPalette.primaryBackground,
              actions: [
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.color_filter,
                    color: AppPalette.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => SearchFiltersPage(),
                      ),
                    );
                  },
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(90),
                child: Column(
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            hintText: "Search startups, posts, reels...",
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            prefixIcon: const Icon(
                              CupertinoIcons.search,
                              color: Colors.grey,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(14),
                          ),
                        ),
                      ),
                    ),

                    // Tabs
                    TabBar(
                      controller: _tabController,
                      physics: _tabController.index == 0
                          ? const NeverScrollableScrollPhysics() // 👈 disable swipe for Projects
                          : const BouncingScrollPhysics(),
                      labelColor: AppPalette.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.greenAccent,
                      tabs: filterTabs.map((t) => Tab(text: t)).toList(),
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _tabController,
                children: [
                  // 👉 All (swipes)
                  // Projects tab
                  NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator(); // remove glow
                      return true;
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.deferToChild,
                      onHorizontalDragUpdate:
                          (_) {}, // consume gestures so TabBarView won’t swipe
                      child: TinderCardsWidget(),
                    ),
                  ),

                  // 👉 Posts tab
                  ListView(
                    children: feedItems
                        .where((i) => i["type"] == "post")
                        .map(
                          (i) => PostWidget(
                            startupName: i["username"],
                            username: i["username"],
                            imageUrl: i["imageUrl"],
                            caption: i["caption"],
                          ),
                        )
                        .toList(),
                  ),

                  // 👉 Reels tab
                  // Reels tab
                  // ListView(
                  //   children: sampleReels
                  //       .map((reel) => ReelsWidget(reelData: reel))
                  //       .toList(),
                  // ),
                  // Reels tab
                  ListView(
                    children: sampleReels
                        .map(
                          (i) => ReelsWidget(
                            startupName: i["ownerFullName"]!,
                            username: i["ownerUsername"]!,
                            videoUrl: i["videoUrl"]!,
                            caption: i["caption"]!,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
      ),
    );
  }
}

/*
ListView(
                    children: feedItems
                        .where((i) => i["type"] == "reel")
                        .map(
                          (i) => ReelsWidget(
                            startupName: i["username"],
                            username: i["username"],
                            videoUrl: i["videoUrl"],
                            caption: i["caption"],
                          ),
                        )
                        .toList(),
                  ),
 */


// ListView(
                  //   children: feedItems
                  //       .where((i) => i["type"] == "post")
                  //       .map(
                  //         (i) => PostWidget(
                  //           startupName: i["username"],
                  //           username: i["username"],
                  //           imageUrl: i["imageUrl"],
                  //           caption: i["caption"],
                  //         ),
                  //       )
                  //       .toList(),
                  // ),