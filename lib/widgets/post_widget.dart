import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/pages/pitch_details_screen.dart';
import 'package:striv/utils/app_palette.dart';

class PostWidget extends StatefulWidget {
  final String pitchid;
  final String postid;
  final String startupName;
  final String username;
  final String imageUrl;
  final String caption;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final bool isSaved;

  const PostWidget({
    super.key,
    required this.pitchid,
    required this.postid,
    required this.startupName,
    required this.username,
    required this.imageUrl,
    required this.caption,
    required this.likesCount,
    required this.commentsCount,
    this.isLiked = false,
    this.isSaved = false,
  });

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late int likes;
  late bool liked;
  late bool saved;

  @override
  void initState() {
    super.initState();
    likes = widget.likesCount;
    liked = widget.isLiked;
    saved = widget.isSaved;
  }

  void toggleLike() {
    setState(() {
      liked = !liked;
      likes += liked ? 1 : -1;
    });
  }

  void toggleSave() {
    setState(() => saved = !saved);
  }

  void openComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(top: Radius.circular(80)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        snap: true,
        snapSizes: [0.5, 0.6],
        initialChildSize: 0.7,
        minChildSize: 0.3,
        maxChildSize: 0.95,
        snapAnimationDuration: Duration(hours: 24),
        builder: (context, scrollController) => ListView(
          controller: scrollController,
          padding: const EdgeInsets.only(top: 8),
          children: [
            Divider(
              thickness: 5,
              color: Colors.black45,
              indent: MediaQuery.of(context).size.width * 0.35,
              endIndent: MediaQuery.of(context).size.width * 0.35,
              radius: BorderRadius.circular(10),
            ),
            const SizedBox(width: 20),
            Center(
              child: Text(
                "Comments",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            Divider(
              thickness: 1,
              color: Colors.black45,
              radius: BorderRadius.circular(10),
            ),
            for (int i = 0; i < widget.commentsCount; i++)
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/32.jpg",
                  ),
                ),
                title: Text("user_$i"),
                subtitle: const Text("This project looks great! 👏"),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=600",
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
                            PitchDetailsScreen(pitchid: widget.pitchid),
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
                icon: const Icon(CupertinoIcons.ellipsis_vertical),
                onPressed: () {},
              ),
            ],
          ),
        ),

        // Full-width post image
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Image.network(
            widget.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                height: 250,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(color: AppPalette.black),
              );
            },
          ),
        ),

        /// Actions Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  liked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  size: 32,
                  color: liked ? Colors.red : Colors.black,
                ),
                onPressed: toggleLike,
              ),
              Text("$likes", style: const TextStyle(fontSize: 14)),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(
                  CupertinoIcons.chat_bubble_2,
                  size: 32,
                  color: Colors.black,
                ),
                onPressed: openComments,
              ),
              Text(
                "${widget.commentsCount}",
                style: const TextStyle(fontSize: 14),
              ),
              const Spacer(),
              IconButton(
                icon: Icon(
                  saved
                      ? CupertinoIcons.bookmark_fill
                      : CupertinoIcons.bookmark,
                  size: 28,
                  color: saved ? Colors.black : Colors.black,
                ),
                onPressed: toggleSave,
              ),
            ],
          ),
        ),

        /// Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            widget.caption,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:striv/pages/pitch_details_screen.dart';

// class PostWidget extends StatelessWidget {
//   final String pitchid;
//   final String postid;
//   final String startupName;
//   final String username;
//   final String imageUrl;
//   final String caption;

//   const PostWidget({
//     super.key,
//     required this.pitchid,
//     required this.postid,
//     required this.startupName,
//     required this.username,
//     required this.imageUrl,
//     required this.caption,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Header: avatar + startup + username
//         // Divider(height: 1),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//           child: Row(
//             children: [
//               const CircleAvatar(
//                 radius: 20,
//                 backgroundImage: NetworkImage(
//                   "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8aW52ZXN0b3J8ZW58MHx8MHx8fDA%3D",
//                 ),
//               ),
//               const SizedBox(width: 10),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.push(
//                       context,
//                       CupertinoPageRoute(
//                         builder: (context) =>
//                             PitchDetailsScreen(pitchid: pitchid),
//                       ),
//                     ),
//                     child: Text(
//                       startupName,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         fontFamily: "Poppins",
//                       ),
//                     ),
//                   ),
//                   Text(
//                     "@$username",
//                     style: const TextStyle(
//                       color: Colors.black54,
//                       fontSize: 12,
//                       fontFamily: "Poppins",
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               const Spacer(),
//               IconButton(
//                 icon: const Icon(CupertinoIcons.dot_radiowaves_left_right),
//                 onPressed: () {},
//               ),
//             ],
//           ),
//         ),

//         // Full-width post image
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.55,
//           child: Image.network(
//             imageUrl,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: 250,
//             loadingBuilder: (context, child, progress) {
//               if (progress == null) return child;
//               return Container(
//                 height: 250,
//                 alignment: Alignment.center,
//                 child: const CircularProgressIndicator(),
//               );
//             },
//           ),
//         ),

//         // Action buttons row
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 2),
//           child: Row(
//             children: [
//               IconButton(
//                 icon: const Icon(CupertinoIcons.heart, size: 32),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: const Icon(CupertinoIcons.chat_bubble_2, size: 32),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: const Icon(CupertinoIcons.doc_text, size: 26),
//                 onPressed: () {},
//               ),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: IconButton(
//                   icon: const Icon(CupertinoIcons.bookmark),
//                   onPressed: () {},
//                 ),
//               ),
//             ],
//           ),
//         ),

//         // Caption
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: RichText(
//             text: TextSpan(
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontFamily: "Poppins",
//               ),
//               children: [
//                 // TextSpan(
//                 //   text: "$startupName  ",
//                 //   style: const TextStyle(
//                 //     fontWeight: FontWeight.bold,
//                 //     fontFamily: "Poppins",
//                 //   ),
//                 // ),
//                 TextSpan(
//                   text: caption,
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         const SizedBox(height: 12),
//       ],
//     );
//   }
// }
