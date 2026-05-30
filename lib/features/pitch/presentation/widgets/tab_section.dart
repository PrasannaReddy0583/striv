import 'package:flutter/material.dart';

class TabSection extends StatefulWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TabSection({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<TabSection> createState() => _TabSectionState();
}

class _TabSectionState extends State<TabSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant TabSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Scroll to the selected tab when index changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedTab();
    });
  }

  void _scrollToSelectedTab() {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabWidth = screenWidth * 0.12; // Approx width per tab
    double offset = widget.selectedIndex * (tabWidth + screenWidth * 0.06);

    // Align selected tab to the start of the screen
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset.clamp(
          _scrollController.position.minScrollExtent,
          _scrollController.position.maxScrollExtent,
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.02,
      ),
      child: Row(
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == widget.selectedIndex;

          return GestureDetector(
            onTap: () => widget.onTabSelected(index),
            child: Container(
              margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.06,
              ),
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.008,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? const Color.fromARGB(255, 240, 171, 32)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                tab,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  color: isSelected
                      ? const Color.fromARGB(255, 240, 171, 32)
                      : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
