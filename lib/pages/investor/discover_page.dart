import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:striv/pages/investor/search_filters_page.dart';
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
  bool isLoadingReels = true;

  final List<String> filterTabs = ['Projects', 'Posts', 'Reels'];

  List<Map<String, dynamic>> swipeCardPitchData = []; // Projects
  List<Map<String, dynamic>> feedItems = []; // Posts
  List<Map<String, dynamic>> reelsData = []; // Reels

  Future<void> fetchProjects() async {
    try {
      final response = await http.get(
        Uri.parse("https://your-api.com/projects"),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        setState(() {
          // Expecting each project has "startupid" and "posterImage"
          swipeCardPitchData = data.map((proj) {
            return {
              "startupid": proj["startupid"] ?? "",
              "posterImage": proj["posterImage"] ?? "",
            };
          }).toList();
        });
      } else {
        debugPrint("Error fetching projects: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching projects: $e");
    }
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

  Future<void> fetchReels() async {
    try {
      final response = await http.get(
        Uri.parse(
          "https://68e74faf10e3f82fbf3e9fac.mockapi.io/delance/post/entrupeneurs/get/reels",
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          reelsData = (data as List).map((reel) {
            return Map<String, dynamic>.from(reel);
          }).toList();

          isLoadingReels = false;
        });
      }
    } catch (e) {
      debugPrint("Error fetching reels: $e");
      setState(() => isLoadingReels = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: filterTabs.length, vsync: this);
    // 👇 Rebuild whenever tab index changes
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
    // Fetch all 3 APIs
    fetchProjects();
    fetchPosts();
    fetchReels();
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
                preferredSize: const Size.fromHeight(100),
                child: Column(
                  children: [
                    // Search Bar
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                      ),
                      child: TextField(
                        cursorColor: AppPalette.black,
                        controller: searchController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppPalette.white,
                          hintText: "Search startups, posts, reels...",
                          hintStyle: TextStyle(color: AppPalette.black),
                          prefixIcon: const Icon(
                            CupertinoIcons.search,
                            color: AppPalette.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(12),
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
                      // indicatorColor: Colors.greenAccent,
                      indicatorColor: AppPalette.black,
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
                  // 👉 Projects tab
                  NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (notification) {
                      notification.disallowIndicator(); // remove glow
                      return true;
                    },
                    child: GestureDetector(
                      behavior: HitTestBehavior.deferToChild,
                      onHorizontalDragUpdate: (_) {}, // block swipe
                      child: TinderCardsWidget(
                        startups:
                            swipeCardPitchData, // 🔹 pass API projects here
                      ),
                    ),
                  ),

                  // 👉 Posts tab
                  ListView(
                    children: feedItems
                        .map(
                          (i) => PostWidget(
                            postid: i["postid"],
                            pitchid: i["startupid"],
                            startupName: i["username"],
                            username: i["username"],
                            imageUrl: i["imageurl"],
                            caption: i["caption"],
                            likesCount: i["likesCount"],
                            commentsCount: i["commentsCount"],
                          ),
                        )
                        .toList(),
                  ),

                  // 👉 Reels tab
                  ListView(
                    children: reelsData
                        .map(
                          (i) => ReelsWidget(
                            startupid: i["startupid"] ?? "",
                            startupName: i["startupName"] ?? "",
                            reelid: i["reelid"] ?? "",
                            username: i["username"] ?? "",
                            videoUrl: i["videoUrl"] ?? "",
                            caption: i["caption"] ?? "",
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
                          (i) => GestureDetector(
                            onTap: () => PitchDetailsScreen(),
                            child: PostWidget(
                              postid: i["postid"],
                              pitchid: i["startupid"],
                              startupName: i["username"],
                              username: i["username"],
                              imageUrl: i["imageUrl"],
                              caption: i["caption"],
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  // Reels
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
                ],
              )
 */

// actions: [
              //   Padding(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 20.0,
              //       vertical: 8,
              //     ),
              //     child: IconButton(
              //       icon: const Icon(
              //         CupertinoIcons.color_filter,
              //         color: AppPalette.black,
              //         size: 30,
              //       ),
              //       onPressed: () {
              //         Navigator.push(
              //           context,
              //           CupertinoPageRoute(
              //             builder: (context) => SearchFiltersPage(),
              //           ),
              //         );
              //       },
              //     ),
              //   ),
              // ],


// ListView(
                  //   children: reelsData.isEmpty
                  //       ? [const Center(child: CircularProgressIndicator())]
                  //       : reelsData
                  //             .map(
                  //               (i) => ReelsWidget(
                  //                 startupid: i["startupid"] as String,
                  //                 startupName: i["startupFullName"] as String,
                  //                 reelid: i["reelid"] as String,
                  //                 username: i["ownerUsername"] as String,
                  //                 videoUrl: i["videoUrl"] as String,
                  //                 caption: i["caption"] as String,
                  //               ),
                  //             )
                  //             .toList(),
                  // ),



/*  Future<void> fetchFeedItems() async {
    final String url;
    try {
      if (widget.isInvestor) {
        url = "https://dummyjson.com/posts?limit=10";
      } else {
        url = "https://dummyjson.com/posts?limit=10";
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          feedItems = (data['posts'] as List).map((post) {
            return {
              "startupid": "1",
              "postid": "post101",
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
 */