import 'package:flutter/material.dart';
import 'package:striv/utils/app_palette.dart';

class DiscoverCardView extends StatelessWidget {
  DiscoverCardView({super.key});

  final List<Map<String, dynamic>> startups = [
    {
      "logo": "assets/green_eats.png",
      "name": "Green Eats",
      "domain": "Food Delivery",
      "description":
          "Revolutionizing food delivery with sustainable, eco-friendly practices.",
      "fundingStage": "Seed",
      "buttonText": "Express Interest",
      "verified": true,
      "fundingAmount": 500000,
      "currency": "₹",
      "equity": 10, // percentage
      "royalty": 5, // percentage
      "type": "Investment", // or Loan
    },
    {
      "logo": "assets/ai_solutions.png",
      "name": "AI Solutions Inc.",
      "domain": "AI Solutions",
      "description":
          "Pioneering AI-driven tools for advanced business optimization and automation.",
      "fundingStage": "Big",
      "buttonText": "Review Pitch",
      "verified": false,
      "fundingAmount": 2000000,
      "currency": "₹",
      "equity": 15,
      "royalty": 0,
      "type": "Loan",
    },
    {
      "logo": "assets/ai_solutions.png",
      "name": "AI Solutions Inc.",
      "domain": "AI | Business",
      "description":
          "Pioneering AI-driven tools for advanced business optimization and automation.",
      "fundingStage": "Series A",
      "buttonText": "Review Pitch",
      "verified": false,
      "fundingAmount": 2000000,
      "currency": "USD",
      "equity": 15,
      "royalty": 0,
      "type": "Loan",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Matching"),
        backgroundColor: AppPalette.primaryBackground,
        foregroundColor: Colors.black,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Filters Row (chips scrollable)
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  FilterChipWidget(label: "Industry"),
                  SizedBox(width: 8),
                  FilterChipWidget(label: "Funding Stage"),
                  SizedBox(width: 8),
                  FilterChipWidget(label: "Revenue Track"),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Startup Cards
            Expanded(
              child: ListView.builder(
                itemCount: startups.length,
                itemBuilder: (context, index) {
                  final startup = startups[index];
                  return StartupCard(startup: startup);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;
  const FilterChipWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.grey[200],
    );
  }
}

class StartupCard extends StatelessWidget {
  final Map<String, dynamic> startup;
  const StartupCard({super.key, required this.startup});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: AppPalette.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with logo + name
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(startup["logo"]),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: startup["verified"]
                          ? Icon(
                              Icons.verified_outlined,
                              size: 18,
                              color: AppPalette.lightgreen,
                            )
                          : Icon(
                              Icons.error_outline,
                              size: 18,
                              color: AppPalette.red,
                            ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        startup["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        startup["domain"],
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Description
            Text(
              startup["description"],
              style: TextStyle(color: Colors.grey[700], fontSize: 13),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // Funding Info
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppPalette.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _fundingRow("Funding Stage", startup["fundingStage"]),
                  _fundingRow(
                    "Amount",
                    "${startup["currency"]} ${startup["fundingAmount"].toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ",")}",
                  ),
                  _fundingRow("Equity", "${startup["equity"]}%"),
                  _fundingRow("Royalty", "${startup["royalty"]}%"),
                  _fundingRow("Type", startup["type"]),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Button
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.messageColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: BorderSide.none,
                ),
                onPressed: () {},
                child: Text(startup["buttonText"]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fundingRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
