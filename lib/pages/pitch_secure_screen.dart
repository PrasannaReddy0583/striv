import 'package:flutter/material.dart';

class Pitch_secure extends StatefulWidget {
  const Pitch_secure({Key? key}) : super(key: key);

  @override
  State<Pitch_secure> createState() => _PitchUploadScreenState();
}

class _PitchUploadScreenState extends State<Pitch_secure> {
  // State variables
  String _pitchVisibility = "Public";
  bool _canDownloadDeck = true;
  bool _canRequestDataRoom = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFCF4EB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFCF4EB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Pitch Upload",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  width: index == 3 ? screenWidth * 0.03 : screenWidth * 0.02,
                  height: index == 3 ? screenWidth * 0.03 : screenWidth * 0.02,
                  decoration: BoxDecoration(
                    color: index == 3
                        ? Color(0xFFEFBA8F)
                        : const Color(0xFFFDF5EE),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),
            SizedBox(height: screenHeight * 0.03),

            Text(
              "Security & Privacy Settings",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Pitch Visibility
            Text(
              "Pitch Visibility",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              children: [
                _buildChoiceChip("Public", screenWidth),
                SizedBox(width: screenWidth * 0.02),
                _buildChoiceChip("Invite-Only", screenWidth),
                SizedBox(width: screenWidth * 0.02),
                _buildChoiceChip("NDA Required", screenWidth),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),

            // Investor Access Controls
            Text(
              "Investor Access Controls",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            _buildSwitchTile(
              title: "Can download deck",
              subtitle: "Investors can save the pitch deck.",
              value: _canDownloadDeck,
              onChanged: (val) {
                setState(() {
                  _canDownloadDeck = val;
                });
              },
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: screenHeight * 0.015),
            _buildSwitchTile(
              title: "Can request data room",
              subtitle: "Investors can request access to more files.",
              value: _canRequestDataRoom,
              onChanged: (val) {
                setState(() {
                  _canRequestDataRoom = val;
                });
              },
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Note: All decks are automatically watermarked with investor ID and timestamp.",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: screenWidth * 0.03,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: screenHeight * 0.035),

            // In-App Features
            Text(
              "In-App Features Overview",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            _buildInfoCard(
              title: "Validation Layers",
              subtitle: "Auto cross-check against government databases.",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: screenHeight * 0.015),
            _buildInfoCard(
              title: "Standardized Cards",
              subtitle:
                  "Data is presented in a consistent, easy-to-digest format.",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: screenHeight * 0.015),
            _buildInfoCard(
              title: "Access Control",
              subtitle: "You control who can access your pitch and data room.",
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
            SizedBox(height: screenHeight * 0.04),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.075,
                        ),
                      ),
                      side: BorderSide(color: Colors.brown.shade200),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.0175,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Back",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.brown.shade200,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFEFBA8F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          screenWidth * 0.075,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.0175,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Submit Pitch",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.04,
                      ),
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

  // --- Widgets ---

  Widget _buildChoiceChip(String label, double screenWidth) {
    return ChoiceChip(
      label: Text(label, style: TextStyle(fontSize: screenWidth * 0.035)),
      selected: _pitchVisibility == label,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _pitchVisibility = label;
          });
        }
      },
      selectedColor: Color(0xFFEFBA8F),
      labelStyle: TextStyle(
        color: _pitchVisibility == label
            ? Colors.white
            : const Color(0xFFEFBA8F),
        fontSize: screenWidth * 0.035,
      ),
      backgroundColor: const Color(0xFFFDF5EE),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: screenWidth * 0.04,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: screenWidth * 0.035,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: const Color.fromARGB(255, 100, 88, 64),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String subtitle,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.035),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: screenWidth * 0.035,
            ),
          ),
          SizedBox(height: screenHeight * 0.0075),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: screenWidth * 0.0325,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
