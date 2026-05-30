import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/features/discover/presentation/pages/full_screen_reel_page.dart';
import 'package:striv/features/pitch/presentation/pages/pitch_details_screen.dart';
import 'package:video_player/video_player.dart';

class ReelsWidget extends StatefulWidget {
  final String startupid;
  final String startupName;
  final String reelid;
  final String username;
  final String videoUrl;
  final String caption;

  const ReelsWidget({
    super.key,
    required this.startupid,
    required this.startupName,
    required this.reelid,
    required this.username,
    required this.videoUrl,
    required this.caption,
  });

  @override
  State<ReelsWidget> createState() => _ReelsWidgetState();
}

class _ReelsWidgetState extends State<ReelsWidget> {
  late VideoPlayerController _controller;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: avatar + startup + username
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=600&auto=format&fit=crop&q=60",
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            PitchDetailsScreen(pitchid: widget.startupid),
                      ),
                    ),
                    child: Text(
                      widget.startupName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Text(
                    "@${widget.username}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(CupertinoIcons.dot_radiowaves_left_right),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Full-width video (tap to open fullscreen)
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FullScreenReelPage(
                  reels: [
                    {
                      "startupid": widget.startupid,
                      "startupName": widget.startupName,
                      "username": widget.username,
                      "reelid": widget.reelid,
                      "videoUrl": widget.videoUrl,
                      "caption": widget.caption,
                    },
                  ],
                  initialIndex: 0,
                ),
              ),
            );
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.55,
            width: double.infinity,
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : const Center(child: CircularProgressIndicator()),
          ),
        ),

        // Action buttons row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.heart, size: 32),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.chat_bubble_2, size: 32),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(CupertinoIcons.doc_text, size: 26),
                onPressed: () {},
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(CupertinoIcons.bookmark),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),

        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "Poppins",
              ),
              children: [
                TextSpan(
                  text: widget.caption,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
