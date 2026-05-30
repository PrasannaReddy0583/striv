import 'package:flutter/material.dart';
import 'package:striv/features/pitch/data/models/pitch_model.dart';
import 'package:striv/features/discover/presentation/widgets/video_player_widget.dart';
import 'package:striv/features/pitch/presentation/widgets/tab_section.dart';
import 'package:striv/features/pitch/presentation/widgets/content_section.dart';
import 'package:striv/features/pitch/presentation/widgets/action_button.dart';
import 'secure_dataroom.dart';

class PitchDetailsScreen extends StatefulWidget {
  final String pitchid;
  const PitchDetailsScreen({super.key, required this.pitchid});

  @override
  State<PitchDetailsScreen> createState() => _PitchDetailsScreenState();
}

class _PitchDetailsScreenState extends State<PitchDetailsScreen> {
  late PitchModel _pitchModel;

  @override
  void initState() {
    super.initState();
    _initializePitchData();
  }

  void _initializePitchData() {
    _pitchModel = PitchModel(
      pitchid: "1",
      companyName: 'Innovate Solutions',
      tagline: 'Revolutionizing urban mobility',
      videoUrl: '',
      problem:
          'Urban commuters face increasing challenges with traffic congestion, limited parking, and environmental concerns. Existing solutions are often fragmented and inefficient.',
      solution:
          'Innovate Solutions offers an integrated platform for shared electric scooters and bikes, providing a convenient, eco-friendly, and cost-effective alternative for short-distance travel.',
      differentiator:
          'Our platform stands out with its advanced AI-powered route optimization, predictive maintenance, and seamless integration with public transport systems.',
      // 👇 Added Funding tab
      tabs: [
        'Overview',
        'Team',
        'Market',
        'Model',
        'Traction & KPI\'s',
        'Funding',
      ],
    );
  }

  void _updateSelectedTab(int index) {
    setState(() {
      _pitchModel = _pitchModel.copyWith(selectedTabIndex: index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF4EB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFCF4EB),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Pitch Details",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Video
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: VideoPlayerWidget(videoUrl: _pitchModel.videoUrl),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // Company Info
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.16,
                    height: MediaQuery.of(context).size.width * 0.16,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.lightbulb_outline,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width * 0.08,
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.05),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _pitchModel.companyName,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        Text(
                          _pitchModel.tagline,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: MediaQuery.of(context).size.width * 0.037,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),

              // Tabs
              TabSection(
                tabs: _pitchModel.tabs,
                selectedIndex: _pitchModel.selectedTabIndex,
                onTabSelected: _updateSelectedTab,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),

              // Content
              ContentSection(pitchModel: _pitchModel),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              // Action Button
              ActionButton(
                text: 'Request More Info',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecureDataRoomScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
