import 'package:flutter/material.dart';
import 'package:striv/pages/entrepreneur/pitch_upload/pitch_step3_track.dart';

class MarketOpportunityForm extends StatefulWidget {
  final Map<String, dynamic> step1Data;

  const MarketOpportunityForm({super.key, required this.step1Data});

  @override
  State<MarketOpportunityForm> createState() => _MarketOpportunityFormState();
}

class _MarketOpportunityFormState extends State<MarketOpportunityForm> {
  final _formKey = GlobalKey<FormState>();

  // Step 2 fields
  String? _selectedIndustry;
  String? _selectedGeography;
  final TextEditingController _keyDifferentiatorController =
      TextEditingController();
  final TextEditingController _tamController = TextEditingController();
  final TextEditingController _marketGrowthController = TextEditingController();

  // New Business Model fields
  String? _selectedRevenueStream;
  String? _selectedChannel;
  final TextEditingController _pricingController = TextEditingController();
  final TextEditingController _goToMarketController = TextEditingController();

  final List<String> _industryTags = [
    "Tech",
    "Healthcare",
    "Finance",
    "Education",
  ];
  final List<String> _geographyTargets = [
    "Global",
    "North America",
    "Europe",
    "Asia",
  ];

  final List<String> _revenueStreams = [
    "Subscription",
    "Freemium",
    "One-time Purchase",
    "Advertising",
    "Licensing",
  ];

  final List<String> _distributionChannels = [
    "Online",
    "Retail",
    "Partners",
    "Direct Sales",
  ];

  @override
  void dispose() {
    _keyDifferentiatorController.dispose();
    _tamController.dispose();
    _marketGrowthController.dispose();
    _pricingController.dispose();
    _goToMarketController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final allData = {
        ...widget.step1Data,
        "industry": _selectedIndustry!,
        "geography": _selectedGeography!,
        "keyDifferentiator": _keyDifferentiatorController.text.trim(),
        "TAM_SAM_SOM": _tamController.text.trim(),
        "marketGrowthRate": _marketGrowthController.text.trim(),
        "revenueStreams": _selectedRevenueStream!,
        "pricingExample": _pricingController.text.trim(),
        "distributionChannels": _selectedChannel!,
        "goToMarketStrategy": _goToMarketController.text.trim(),
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TractionKPIsForm(data: allData),
        ),
      );
    }
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(12),
          ),
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
          validator: (val) => val == null || val.isEmpty ? "Required" : null,
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(height: 6),
        TextFormField(
          controller: controller,
          validator: (val) => val == null || val.isEmpty ? "Required" : null,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(12),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF5EE),
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF5EE),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Market Opportunity",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(54),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Step 2 of 5",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 2 / 5,
                    minHeight: 6,
                    backgroundColor: Colors.brown.shade100,
                    valueColor: AlwaysStoppedAnimation(Colors.brown.shade300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Step 2 fields
              _buildDropdown(
                label: "Industry / Sector Tags",
                value: _selectedIndustry,
                items: _industryTags,
                onChanged: (val) => setState(() => _selectedIndustry = val),
              ),
              _buildDropdown(
                label: "Geography Target",
                value: _selectedGeography,
                items: _geographyTargets,
                onChanged: (val) => setState(() => _selectedGeography = val),
              ),
              _buildTextField(
                label: "Key Differentiator",
                controller: _keyDifferentiatorController,
                hint: "e.g., Proprietary AI algorithm",
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: "TAM / SAM / SOM",
                      controller: _tamController,
                      hint: "\$1B / \$100M / \$10M",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      label: "Market Growth Rate",
                      controller: _marketGrowthController,
                      hint: "e.g., 15% CAGR",
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // New Business Model section
              Text(
                "Business Model",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              _buildDropdown(
                label: "Revenue Streams",
                value: _selectedRevenueStream,
                items: _revenueStreams,
                onChanged: (val) =>
                    setState(() => _selectedRevenueStream = val),
              ),
              _buildTextField(
                label: "Current Pricing Example",
                controller: _pricingController,
                hint: "e.g., \$99/month Pro Plan",
              ),
              _buildDropdown(
                label: "Distribution Channels",
                value: _selectedChannel,
                items: _distributionChannels,
                onChanged: (val) => setState(() => _selectedChannel = val),
              ),
              _buildTextField(
                label: "Go-To-Market Strategy",
                controller: _goToMarketController,
                hint: "Describe your strategy",
                maxLines: 4,
              ),

              SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        color: Color(0xFFFDF5EE),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => () {},
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.brown.shade200),
                ),
                child: Text(
                  'Save Draft',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade200,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarketOpportunityPreview extends StatelessWidget {
  final Map<String, dynamic> data;

  const MarketOpportunityPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Preview")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Display Step 1 + Step 2 + Business Model data
            Text("1-Liner: ${data['oneLiner']}"),
            Text("Detailed Problem: ${data['detailedProblem']}"),
            Text("Evidence: ${data['evidence']}"),
            Text("Product Description: ${data['productDescription']}"),
            Text("Pitch Deck: ${data['pitchDeck']}"),
            Text("Video Pitch: ${data['videoPitch']}"),
            SizedBox(height: 12),
            Text("Industry: ${data['industry']}"),
            Text("Geography: ${data['geography']}"),
            Text("Key Differentiator: ${data['keyDifferentiator']}"),
            Text("TAM/SAM/SOM: ${data['TAM_SAM_SOM']}"),
            Text("Market Growth Rate: ${data['marketGrowthRate']}"),
            SizedBox(height: 12),
            Text("Revenue Streams: ${data['revenueStreams']}"),
            Text("Pricing Example: ${data['pricingExample']}"),
            Text("Distribution Channels: ${data['distributionChannels']}"),
            Text("Go-To-Market Strategy: ${data['goToMarketStrategy']}"),
          ],
        ),
      ),
    );
  }
}
