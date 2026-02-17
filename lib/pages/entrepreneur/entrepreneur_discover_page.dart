import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:striv/data/dummy_reels_api.dart';
import 'package:striv/pages/search_filters_page.dart';
import 'package:striv/utils/app_palette.dart';
import 'package:striv/widgets/post_widget.dart';
import 'package:striv/widgets/reels_widget.dart';

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

  // final sampleReels = [
  //   {
  //     "videoUrl":
  //         "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  //     "caption": "Check out this amazing animation!",
  //     "ownerFullName": "Blender Foundation",
  //     "ownerUsername": "blender",
  //   },
  //   {
  //     "videoUrl":
  //         "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
  //     "caption": "Sintel short film clip",
  //     "ownerFullName": "Blender Studio",
  //     "ownerUsername": "blenderstudio",
  //   },
  // ];

  List<Map<String, dynamic>> reelsData = [];
  List<Map<String, dynamic>> feedItems = [];

  Future<void> fetchReels() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay
    setState(() {
      reelsData = dummyReelsApi; // pretend this came from API
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: filterTabs.length, vsync: this);
    // 👇 Rebuild whenever tab index changes
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://68e74faf10e3f82fbf3e9fac.mockapi.io/delance/post/entrupeneurs/get/posts",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          feedItems = (data as List).map((post) {
            return Map<String, dynamic>.from(post);
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
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Discover",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.textPrimary,
                      ),
                    ),
                    CircleAvatar(
                      radius: 21,
                      backgroundColor: AppPalette.white,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => SearchFiltersPage(),
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.color_filter,
                          color: AppPalette.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floating: _tabController.index != 0 ? true : false,
              snap: _tabController.index != 0 ? true : false,
              pinned: _tabController.index != 0
                  ? false
                  : true, // 👈 keeps tabs visible
              backgroundColor: AppPalette.primaryBackground,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(105),
                child: Column(
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
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
                    ),
                  ),

                  // 👉 Posts tab
                  ListView(
                    children: feedItems
                        .where((i) => i["type"] == "post")
                        .map(
                          (i) => PostWidget(
                            pitchid: i["startupid"],
                            postid: i["postid"],
                            startupName: i["username"],
                            username: i["username"],
                            imageUrl: i["imageUrl"],
                            caption: i["caption"],
                            likesCount: i["likesCount"],
                            commentsCount: i["commentsCount"],
                          ),
                        )
                        .toList(),
                  ),

                  // 👉 Reels tab
                  /*
                  ListView(
                    children: sampleReels
                        .map(
                          (i) => ReelsWidget(
                            startupid: i["startupid"]!,
                            startupName: i["startupFullName"]!,
                            reelid: i["reelid"]!,
                            username: i["ownerUsername"]!,
                            videoUrl: i["videoUrl"]!,
                            caption: i["caption"]!,
                          ),
                        )
                        .toList(),
                  ),
                  */
                  ListView(
                    children: reelsData.isEmpty
                        ? [const Center(child: CircularProgressIndicator())]
                        : reelsData
                              .map(
                                (i) => ReelsWidget(
                                  startupid: i["startupid"] as String,
                                  startupName: i["startupFullName"] as String,
                                  reelid: i["reelid"] as String,
                                  username: i["ownerUsername"] as String,
                                  videoUrl: i["videoUrl"] as String,
                                  caption: i["caption"] as String,
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
