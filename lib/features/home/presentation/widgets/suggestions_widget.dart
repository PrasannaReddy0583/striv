import 'package:flutter/material.dart';

class SuggestionsWidget extends StatelessWidget {
  final List<String> usernames;

  const SuggestionsWidget({super.key, required this.usernames});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Suggestions for you",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: usernames.length,
            itemBuilder: (context, index) {
              return Container(
                width: 80,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(
                        "https://via.placeholder.com/50",
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      usernames[index],
                      style: const TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const Divider(),
      ],
    );
  }
}
