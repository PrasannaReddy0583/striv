import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:striv/features/pitch/presentation/pages/pitch_details_screen.dart';

class TinderCardsWidget extends StatefulWidget {
  final List<Map<String, dynamic>> startups;
  const TinderCardsWidget({super.key, required this.startups});

  @override
  State<TinderCardsWidget> createState() => _TinderCardsWidgetState();
}

class _TinderCardsWidgetState extends State<TinderCardsWidget> {
  List<Map<String, String>> startups = [
    {
      "name": "Solar Labs",
      // "username": "JessyPinkmen@505",
      "image": "https://picsum.photos/400/600?random=1",
      "desc": "Green energy startup focusing on solar innovation.",
      "funding": "\$250k for 10% equity",
    },
    {
      "name": "Healthify",
      // "username": "Heisenberg@644",
      "image": "https://picsum.photos/400/600?random=2",
      "desc": "AI-driven health diagnostics platform.",
      "funding": "\$500k for 15% equity",
    },
    {
      "name": "FoodChain",
      // "username": "Dexter@644",
      "image": "https://picsum.photos/400/600?random=3",
      "desc": "Farm-to-table blockchain solution.",
      "funding": "\$150k for 8% equity",
    },
  ];

  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.045,
        bottom: MediaQuery.of(context).size.width * 0.19,
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03,
      ),
      child: Swiper(
        itemCount: startups.length,
        layout: SwiperLayout.DEFAULT,
        controller: _swiperController,
        itemWidth: MediaQuery.of(context).size.width * 0.9,
        itemHeight: MediaQuery.of(context).size.height * 0.65,
        physics: BouncingScrollPhysics(),

        itemBuilder: (context, index) {
          final startup = startups[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                Image.network(startup["image"]!, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    spacing: 6,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) =>
                                PitchDetailsScreen(pitchid: "123"),
                          ),
                        ),
                        child: Text(
                          startup["name"]!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Text(
                      //   startup["username"]!,
                      //   style: const TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      Text(
                        startup["desc"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        startup["funding"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        onIndexChanged: (index) {
          debugPrint("Current index: $index");
        },
        onTap: (index) {
          debugPrint("Card tapped: $index");
        },
      ),
    );
  }
   
  /*
  Widget _actionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
  */

  void _showPeekDialog(BuildContext context, Map<String, String> startup) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(startup["name"]!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(startup["image"]!),
            const SizedBox(height: 12),
            Text(startup["desc"]!),
            const SizedBox(height: 8),
            Text(
              startup["funding"]!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}





/*
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:striv/features/pitch/presentation/pages/pitch_details_screen.dart';

class TinderCardsWidget extends StatefulWidget {
  final List<Map<String, dynamic>> startups;
  const TinderCardsWidget({super.key, required this.startups});

  @override
  State<TinderCardsWidget> createState() => _TinderCardsWidgetState();
}

class _TinderCardsWidgetState extends State<TinderCardsWidget> {
  final SwiperController _swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.045,
        bottom: MediaQuery.of(context).size.width * 0.19,
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03,
      ),
      child: Swiper(
        itemCount: widget.startups.length,
        layout: SwiperLayout.DEFAULT,
        controller: _swiperController,
        itemWidth: MediaQuery.of(context).size.width * 0.9,
        itemHeight: MediaQuery.of(context).size.height * 0.65,
        physics: BouncingScrollPhysics(),

        itemBuilder: (context, index) {
          final startup = widget.startups[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              fit: StackFit.passthrough,
              children: [
                GestureDetector(
                  onTap: () => PitchDetailsScreen(pitchid: startup["pitchid"]),
                  child: Image.network(
                    startup["posterImage"],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        },
        onIndexChanged: (index) {
          debugPrint("Current index: $index");
        },
        onTap: (index) {
          debugPrint("Card tapped: $index");
        },
      ),
    );
  }
}
*/