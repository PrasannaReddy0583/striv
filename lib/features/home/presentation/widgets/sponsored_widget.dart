import 'package:flutter/material.dart';

class SponsoredWidget extends StatelessWidget {
  final String brand;
  final String imageUrl;
  final String description;

  const SponsoredWidget({
    super.key,
    required this.brand,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const CircleAvatar(
            backgroundImage: NetworkImage("https://via.placeholder.com/50"),
          ),
          title: Text("$brand • Sponsored"),
          trailing: const Icon(Icons.more_vert),
        ),
        Image.network(imageUrl, fit: BoxFit.cover),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(description)),
        const Divider(),
      ],
    );
  }
}
