import 'package:flutter/material.dart';

class DiscussScreen extends StatefulWidget {
  final String category;
  const DiscussScreen({super.key, required this.category});

  @override
  State<DiscussScreen> createState() => _DiscussScreenState();
}

class _DiscussScreenState extends State<DiscussScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Example posts
  List<Post> posts = [
    Post(
      id: '1',
      authorName: 'Sarah Chen',
      role: 'Entrepreneur',
      avatarInitials: 'S',
      title: 'How to pitch to investors?',
      body: 'What are the key elements of a successful pitch deck?',
      likes: 12,
      comments: [Comment(author: 'John Doe', text: 'Focus on clarity.')],
      shares: 2,
      category: 'Discuss',
    ),
  ];

  List<Post> _filteredPosts() {
    final q = _searchQuery.trim().toLowerCase();
    return posts.where((p) {
      final matchesCategory = p.category == widget.category;
      final matchesQuery = q.isEmpty ||
          p.title.toLowerCase().contains(q) ||
          p.body.toLowerCase().contains(q) ||
          p.authorName.toLowerCase().contains(q);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredPosts();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFDF5EC), Color(0xFFF5E7DA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom top row with back button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Color(0xFF57493F)),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      widget.category,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF57493F),
                      ),
                    ),
                    SizedBox(width: 48), // placeholder for symmetry
                  ],
                ),
              ),

              // Search bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Search in ${widget.category}...',
                    prefixIcon: Icon(Icons.search, color: Color(0xFFEFBA8F)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              // Posts list
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Text(
                          "No posts yet",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final post = filtered[index];
                          return PostCard(
                            post: post,
                            onLike: () {
                              setState(() {
                                post.isLiked = !post.isLiked;
                                post.likes += post.isLiked ? 1 : -1;
                              });
                            },
                            onComment: (text) {
                              setState(() {
                                post.comments.add(
                                  Comment(author: "You", text: text),
                                );
                              });
                            },
                            onShare: () {
                              setState(() {
                                post.shares++;
                              });
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---- Post Models + UI ----
class Post {
  final String id;
  final String authorName;
  final String role;
  final String avatarInitials;
  final String title;
  final String body;
  int likes;
  int shares;
  bool isLiked;
  List<Comment> comments;
  final String category;

  Post({
    required this.id,
    required this.authorName,
    required this.role,
    required this.avatarInitials,
    required this.title,
    required this.body,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.category,
    this.isLiked = false,
  });
}

class Comment {
  final String author;
  final String text;
  Comment({required this.author, required this.text});
}

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final Function(String) onComment;
  final VoidCallback onShare;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFEFBA8F).withOpacity(0.2),
                child: Text(
                  post.avatarInitials,
                  style: TextStyle(color: Color(0xFFEFBA8F)),
                ),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.authorName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    post.role,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10),

          // Title
          Text(post.title,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 6),

          // Body
          Text(post.body,
              maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black87)),

          SizedBox(height: 10),

          // Actions
          Row(
            children: [
              IconButton(
                icon: Icon(
                  post.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                  color: Color(0xFFEFBA8F),
                ),
                onPressed: onLike,
              ),
              Text(post.likes.toString()),
              IconButton(
                icon: Icon(Icons.comment_outlined,
                    color: Color(0xFFEFBA8F)),
                onPressed: () => _showComments(context),
              ),
              Text(post.comments.length.toString()),
              IconButton(
                icon: Icon(Icons.share_outlined,
                    color: Color(0xFFEFBA8F)),
                onPressed: onShare,
              ),
              Text(post.shares.toString()),
            ],
          ),
        ],
      ),
    );
  }

  void _showComments(BuildContext context) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Color(0xFFFDF5EC),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 12,
            right: 12,
            top: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView(
              shrinkWrap: true,
              children: post.comments
                  .map(
                    (c) => ListTile(
                      leading: Icon(Icons.person,
                          color: Color(0xFFEFBA8F)),
                      title: Text(c.author),
                      subtitle: Text(c.text),
                    ),
                  )
                  .toList(),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color(0xFFEFBA8F)),
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      onComment(controller.text);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
