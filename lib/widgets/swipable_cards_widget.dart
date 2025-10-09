import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:striv/pages/pitch_details_screen.dart';

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
