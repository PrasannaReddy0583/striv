import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/utils/app_palette.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class FullScreenReelPage extends StatefulWidget {
  final List<Map<String, dynamic>> reels;
  final int initialIndex;

  const FullScreenReelPage({
    super.key,
    required this.reels,
    required this.initialIndex,
  });

  @override
  State<FullScreenReelPage> createState() => _FullScreenReelPageState();
}

class _FullScreenReelPageState extends State<FullScreenReelPage> {
  late PageController _pageController;
  late int currentIndex;
  final Map<int, VideoPlayerController> _controllers = {};
  final Map<int, ChewieController> _chewieControllers = {};

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
    _initVideo(currentIndex);
  }

  void _initVideo(int index) {
    if (_controllers[index] != null) return;

    final reel = widget.reels[index];
    final controller = VideoPlayerController.network(reel['videoUrl']);
    final chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: true,
      showControls: true,
      fullScreenByDefault: true,
      customControls: Center(
        child: Container(color: Colors.white, child: Text("Hello")),
      ),
    );

    controller.initialize().then((_) {
      setState(() {});
      controller.play();
    });

    _controllers[index] = controller;
    _chewieControllers[index] = chewieController;
  }

  void _disposeVideo(int index) {
    _controllers[index]?.dispose();
    _chewieControllers[index]?.dispose();
    _controllers.remove(index);
    _chewieControllers.remove(index);
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) => value.dispose());
    _chewieControllers.forEach((key, value) => value.dispose());
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildReelOverlay(Map<String, dynamic> reel) {
    return Stack(
      children: [
        // 🔝 AppBar (Top)
        Positioned(
          top: 40,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 32,
                children: [
                  GestureDetector(
                    child: Icon(
                      CupertinoIcons.back,
                      color: AppPalette.white,
                      size: 30,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  Text(
                    "Reels",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 28,
              ),
            ],
          ),
        ),

        // ➡️ Right-side buttons
        Positioned(
          right: 12,
          bottom: 100,
          child: Column(
            children: [
              _actionButton(CupertinoIcons.heart, reel['likes'] ?? 0),
              const SizedBox(height: 20),
              _actionButton(CupertinoIcons.chat_bubble, reel['comments'] ?? 0),
              const SizedBox(height: 20),
              const Icon(
                CupertinoIcons.ellipsis_vertical_circle,
                color: Colors.white,
                size: 30,
              ),
            ],
          ),
        ),

        // ⬇️ Bottom Info (Username + Caption + Song)
        Positioned(
          bottom: 30,
          left: 16,
          right: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 8,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(reel['ownerPic'] ?? ""),
                  ),
                  Column(
                    children: [
                      Text(
                        reel['startupName'] ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        reel['username'] ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    child: const Text(
                      "Follow",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                reel['caption'] ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Row(
                children: const [
                  Icon(Icons.music_note, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    "Original audio",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionButton(IconData icon, int count) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 4),
        Text(
          "$count",
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.reels.length,
        onPageChanged: (index) {
          _disposeVideo(currentIndex);
          currentIndex = index;
          _initVideo(currentIndex);
        },
        itemBuilder: (context, index) {
          final reel = widget.reels[index];
          final chewie = _chewieControllers[index];

          return chewie != null && _controllers[index]!.value.isInitialized
              ? Stack(
                  children: [
                    Chewie(controller: chewie),
                    _buildReelOverlay(reel),
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class FullScreenReelPage extends StatefulWidget {
  final List<Map<String, dynamic>> reels;
  final int initialIndex;

  const FullScreenReelPage({
    super.key,
    required this.reels,
    required this.initialIndex,
  });

  @override
  State<FullScreenReelPage> createState() => _FullScreenReelPageState();
}

class _FullScreenReelPageState extends State<FullScreenReelPage> {
  late PageController _pageController;
  late int currentIndex;
  final Map<int, VideoPlayerController> _controllers = {};
  final Map<int, ChewieController> _chewieControllers = {};

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
    _initVideo(currentIndex);
  }

  void _initVideo(int index) {
    if (_controllers[index] != null) return;

    final reel = widget.reels[index];
    final controller = VideoPlayerController.network(reel['videoUrl']);
    final chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: true,
      showControls: false,
    );

    controller.initialize().then((_) {
      setState(() {});
      controller.play();
    });

    _controllers[index] = controller;
    _chewieControllers[index] = chewieController;
  }

  void _disposeVideo(int index) {
    _controllers[index]?.dispose();
    _chewieControllers[index]?.dispose();
    _controllers.remove(index);
    _chewieControllers.remove(index);
  }

  @override
  void dispose() {
    _controllers.forEach((key, value) => value.dispose());
    _chewieControllers.forEach((key, value) => value.dispose());
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.reels.length,
        onPageChanged: (index) {
          _disposeVideo(currentIndex);
          currentIndex = index;
          _initVideo(currentIndex);
        },
        itemBuilder: (context, index) {
          final reel = widget.reels[index];
          final chewie = _chewieControllers[index];

          return chewie != null && _controllers[index]!.value.isInitialized
              ? Stack(
                  children: [
                    Chewie(controller: chewie),
                    Positioned(
                      bottom: 20,
                      left: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reel['ownerFullName'] ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            reel['caption'] ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
*/