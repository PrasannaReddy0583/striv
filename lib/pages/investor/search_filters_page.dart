import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:striv/utils/app_palette.dart';

class SearchFiltersPage extends StatefulWidget {
  const SearchFiltersPage({super.key});

  @override
  State<SearchFiltersPage> createState() => _SearchFiltersPageState();
}

class _SearchFiltersPageState extends State<SearchFiltersPage> {
  // Selected filter states
  Set<String> selectedIndustries = {"AI"};
  Set<String> selectedFunding = {"Seed"};
  Set<String> selectedRevenue = {"Generating Revenue"};
  Set<String> selectedGeography = {"Asia"};

  double investmentRange = 100000; // default $100k
  double teamSize = 10; // default team size

  // Helper for building choice chips
  Widget buildChoiceChips(
    String title,
    List<String> options,
    Set<String> selectedSet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((option) {
            final isSelected = selectedSet.contains(option);
            return ChoiceChip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(
                  Radius.elliptical(20, 20),
                ),
              ),
              label: Text(
                option,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.brown,
                ),
              ),
              selected: isSelected,
              selectedColor: const Color(0xFFD9BBA0),
              backgroundColor: const Color(0xFFF2EDE9),
              onSelected: (selected) {
                setState(() {
                  if (selected) {
                    selectedSet.add(option);
                  } else {
                    selectedSet.remove(option);
                  }
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPalette.primaryBackground,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(CupertinoIcons.back, color: Colors.brown, size: 30),
        ),
        title: Text(
          "Startup Filter",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.brown),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => (),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                CupertinoIcons.refresh_bold,
                weight: 40,
                size: 30,
                color: AppPalette.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search startup name, keyword...",
                hintStyle: TextStyle(color: Colors.brown[300]),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, color: Colors.brown),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Industry Sector
            buildChoiceChips("Industry/Sector", [
              "Fintech",
              "AI",
              "Healthcare",
              "E-commerce",
              "SaaS",
            ], selectedIndustries),

            // Funding Stage
            buildChoiceChips("Funding Stage", [
              "Seed",
              "Series A",
              "Growth",
            ], selectedFunding),

            // Investment Range
            Text(
              "Investment Range",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Slider(
              value: investmentRange,
              min: 10000,
              max: 5000000,
              divisions: 50,
              label: "\$${(investmentRange / 1000).round()}k",
              activeColor: Colors.brown,
              onChanged: (value) {
                setState(() {
                  investmentRange = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$10k", style: TextStyle(color: Colors.brown)),
                Text("\$5M+", style: TextStyle(color: Colors.brown)),
              ],
            ),
            const SizedBox(height: 20),

            // Revenue/Traction
            buildChoiceChips("Revenue/Traction", [
              "Pre-revenue",
              "Generating Revenue",
            ], selectedRevenue),

            // Geography
            buildChoiceChips("Geography", [
              "USA",
              "Europe",
              "Asia",
            ], selectedGeography),

            // Team Size
            Text(
              "Team Size",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Slider(
              value: teamSize,
              min: 1,
              max: 100,
              divisions: 20,
              label: teamSize.round().toString(),
              activeColor: Colors.brown,
              onChanged: (value) {
                setState(() {
                  teamSize = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("1", style: TextStyle(color: Colors.brown)),
                Text("100+", style: TextStyle(color: Colors.brown)),
              ],
            ),
            const SizedBox(height: 30),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedIndustries.clear();
                      selectedFunding.clear();
                      selectedRevenue.clear();
                      selectedGeography.clear();
                      investmentRange = 100000;
                      teamSize = 10;
                    });
                  },
                  child: Text(
                    "Clear All",
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD9BBA0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                  ),
                  onPressed: () {
                    // Apply filter logic
                  },
                  child: Text(
                    "Apply Filters",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
