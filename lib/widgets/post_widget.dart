import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/pages/pitch_details_screen.dart';

class PostWidget extends StatelessWidget {
  final String pitchid;
  final String postid;
  final String startupName;
  final String username;
  final String imageUrl;
  final String caption;

  const PostWidget({
    super.key,
    required this.pitchid,
    required this.postid,
    required this.startupName,
    required this.username,
    required this.imageUrl,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header: avatar + startup + username
        // Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8aW52ZXN0b3J8ZW58MHx8MHx8fDA%3D",
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
                            PitchDetailsScreen(pitchid: pitchid),
                      ),
                    ),
                    child: Text(
                      startupName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Text(
                    "@$username",
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

        // Full-width post image
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                height: 250,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            },
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
                // TextSpan(
                //   text: "$startupName  ",
                //   style: const TextStyle(
                //     fontWeight: FontWeight.bold,
                //     fontFamily: "Poppins",
                //   ),
                // ),
                TextSpan(
                  text: caption,
                  style: TextStyle(
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
