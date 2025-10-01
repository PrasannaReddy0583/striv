import 'package:flutter/material.dart';
import 'package:striv/utils/app_palette.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key, required bool isInvestor});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  int _selectedIndex = 1;

  final List<Map<String, dynamic>> startUps = [
    {
      "startupid": "1",
      "image":
          "https://media.istockphoto.com/id/1807617224/photo/newspaper-advertising-magazine-brochure-mockup-3d-rendering.webp?a=1&b=1&s=612x612&w=0&k=20&c=AALn3ijokuacHzGTunsIdV_J5g56_DJUWj8gl2Etnbw=",
      "title": "InnovateU",
      "username": "User@3512",
      "description":
          "AI-powered platform for personalized education. Seeking \$500K for seed funding.",
      "tags": ["AI", "EdTech", "Education", "Fianace", "Programming"],
      "verifiedStatus": true,
    },
    {
      "startupid": "1",
      "image":
          "https://media.istockphoto.com/id/1807720170/photo/newspaper-advertising-magazine-brochure-mockup-3d-rendering.webp?a=1&b=1&s=612x612&w=0&k=20&c=oOi4cklXiXLKtJs2WIr9nOk1SZ9cIJ0AE8xihHFXjys=",
      "title": "Synergy Corp",
      "username": "User@5112",
      "description":
          "B2B SaaS solution for optimizing supply chains. Raising \$1.2M for Series A.",
      "tags": ["SaaS", "Supply Chain", "Series A"],
      "verifiedStatus": false,
    },
    {
      "startupid": "1",
      "image":
          "https://images.unsplash.com/photo-1637844528486-6dc108bd5c7f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGNvbXBhbnklMjBhZHZlcnRpc21lbnR8ZW58MHx8MHx8fDA%3D",
      "title": "EcoWave",
      "username": "User@4421",
      "description":
          "Sustainable energy startup building wave-powered generators. Raising \$800K for growth.",
      "tags": ["CleanTech", "Energy", "Series A"],
      "verifiedStatus": true,
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppPalette.primaryBackground,
        surfaceTintColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Requests",
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: startUps.length,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemBuilder: (context, index) {
            final startup = startUps[index];
            return buildCompanyCard(
              image: startup["image"],
              title: startup["title"],
              username: startup["username"],
              description: startup["description"],
              tags: List<String>.from(startup["tags"]),
              isVerified: startup["verifiedStatus"],
            );
          },
        ),
      ),
    );
  }

  Widget buildCompanyCard({
    required String image,
    required String title,
    required String username,
    required String description,
    required List<String> tags,
    required bool isVerified,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 226, 209),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              image,
              height: MediaQuery.of(context).size.height * 0.50,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: const Icon(
                    Icons.error_outline,
                    size: 50,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    spacing: 12,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1657947953120-6e5201f3b3ed?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dWJlciUyMGxvZ298ZW58MHx8MHx8fDA%3D",
                        ),
                        radius: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            spacing: 4,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Icon(
                                isVerified
                                    ? Icons.verified_outlined
                                    : Icons.error_outline,
                                fill: 1,
                                color: isVerified
                                    ? AppPalette.lightgreen
                                    : AppPalette.red,
                              ),
                            ],
                          ),

                          // Location
                          Text(
                            username,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Text(
                //   description,
                //   style: TextStyle(
                //     fontFamily: "Poppins",
                //     fontSize: 14,
                //     fontWeight: FontWeight.w400,
                //     color: Colors.grey.shade800,
                //   ),
                // ),

                // Tags
                Wrap(
                  spacing: 2,
                  runSpacing: -8,
                  children: tags
                      .map(
                        (tag) => Chip(
                          label: Text(
                            tag,
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppPalette.messageColor,
                            ),
                          ),
                          backgroundColor: AppPalette.primaryBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      )
                      .toList(),
                ),

                const SizedBox(height: 8),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 45),
                          side: BorderSide.none,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        child: const Text(
                          "Ignore",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 45),
                          backgroundColor: AppPalette.messageColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          side: BorderSide.none,
                        ),
                        child: const Text(
                          "Peek",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:striv/utils/app_palette.dart';

// class RequestsPage extends StatefulWidget {
//   const RequestsPage({super.key});

//   @override
//   State<RequestsPage> createState() => _RequestsPageState();
// }

// class _RequestsPageState extends State<RequestsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppPalette.primaryBackground,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(CupertinoIcons.back, color: Colors.brown, size: 30),
//           onPressed: () {},
//         ),
//         title: Text(
//           "Requests",
//           style: TextStyle(
//             fontFamily: "Poppins",
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.brown[800],
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list, color: Colors.brown),
//             onPressed: () {},
//           ),
//         ],
//       ),

//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Column(
//           children: [
//             // Filter chips
//             Row(
//               children: [
//                 FilterChipWidget(label: "Industry"),
//                 const SizedBox(width: 8),
//                 FilterChipWidget(label: "Funding Stage"),
//                 const SizedBox(width: 8),
//                 FilterChipWidget(label: "Revenue Track"),
//               ],
//             ),
//             const SizedBox(height: 16),

//             // Startup cards
//             Expanded(
//               child: ListView(
//                 children: const [
//                   StartupCard(
//                     logo: "assets/logos/green.png",
//                     name: "Green Eats",
//                     industry: "Food Delivery",
//                     description:
//                         "Revolutionizing food delivery with sustainable, eco-friendly practices.",
//                     stage: "Seed",
//                     buttonText: "Express Interest",
//                   ),
//                   StartupCard(
//                     logo: "assets/logos/ai.png",
//                     name: "AI Solutions Inc.",
//                     industry: "AI Solutions",
//                     description:
//                         "Pioneering AI-driven tools for advanced business optimization and automation.",
//                     stage: "Series A",
//                     buttonText: "Review Pitch",
//                   ),
//                   StartupCard(
//                     logo: "assets/logos/ecotech.png",
//                     name: "EcoTech Innovations",
//                     industry: "GreenTech",
//                     description:
//                         "Developing next-gen eco-friendly technologies for a sustainable future.",
//                     stage: "Pre-Seed",
//                     buttonText: "Express Interest",
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),

//       // Bottom Nav Bar
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: const Color(0xFFFDFBF9),
//         selectedItemColor: Colors.brown,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: "Dashboard",
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.people), label: "Matches"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chat_bubble_outline),
//             label: "Messages",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             label: "Profile",
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Filter chip
// class FilterChipWidget extends StatelessWidget {
//   final String label;

//   const FilterChipWidget({super.key, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(25),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               label,
//               style: const TextStyle(
//                 fontFamily: "Poppins",
//                 fontSize: 14,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.brown,
//               ),
//             ),
//             const Icon(Icons.arrow_drop_down, color: Colors.brown),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Startup card
// class StartupCard extends StatelessWidget {
//   final String logo;
//   final String name;
//   final String industry;
//   final String description;
//   final String stage;
//   final String buttonText;

//   const StartupCard({
//     super.key,
//     required this.logo,
//     required this.name,
//     required this.industry,
//     required this.description,
//     required this.stage,
//     required this.buttonText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 8,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Logo
//           CircleAvatar(radius: 28, backgroundImage: AssetImage(logo)),
//           const SizedBox(width: 14),

//           // Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 Text(
//                   industry,
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   description,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.grey[600],
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   "Funding Stage",
//                   style: TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.grey[700],
//                   ),
//                 ),
//                 Text(
//                   stage,
//                   style: const TextStyle(
//                     fontFamily: "Poppins",
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFFE6CFC2),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       elevation: 0,
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 10,
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: Text(
//                       buttonText,
//                       style: const TextStyle(
//                         fontFamily: "Poppins",
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.brown,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
