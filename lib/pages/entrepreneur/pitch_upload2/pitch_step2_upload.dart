import 'package:flutter/material.dart';
import 'package:striv/pages/entrepreneur/pitch_upload2/pitch_step3_track.dart';

class MarketOpportunityForm extends StatefulWidget {
  final Map<String, dynamic> step1Data;

  const MarketOpportunityForm({super.key, required this.step1Data});

  @override
  State<MarketOpportunityForm> createState() => _MarketOpportunityFormState();
}

class _MarketOpportunityFormState extends State<MarketOpportunityForm> {
  final _formKey = GlobalKey<FormState>();

  // Multi-select fields
  List<String> _selectedIndustries = [];
  List<String> _selectedGeographies = [];
  List<String> _selectedRevenueStreams = [];
  List<String> _selectedChannels = [];

  final TextEditingController _keyDifferentiatorController =
      TextEditingController();
  final TextEditingController _tamController = TextEditingController();
  final TextEditingController _samController = TextEditingController();
  final TextEditingController _somController = TextEditingController();
  final TextEditingController _marketGrowthController = TextEditingController();

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
    _samController.dispose();
    _somController.dispose();
    _marketGrowthController.dispose();
    _pricingController.dispose();
    _goToMarketController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final allData = {
        ...widget.step1Data,
        "industry": _selectedIndustries,
        "geography": _selectedGeographies,
        "keyDifferentiator": _keyDifferentiatorController.text.trim(),
        "TAM": _tamController.text.trim(),
        "SAM": _samController.text.trim(),
        "SOM": _somController.text.trim(),
        "marketGrowthRate": _marketGrowthController.text.trim(),
        "revenueStreams": _selectedRevenueStreams,
        "pricingExample": _pricingController.text.trim(),
        "distributionChannels": _selectedChannels,
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction, // 👈 add this
          validator: (val) => val == null || val.isEmpty ? "Required" : null,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.brown.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.brown.shade300, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
              ), // red when invalid
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ), // red focus when invalid
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(12),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  /// 🔥 Reusable Multi-Select (with dialog + chips)
  Widget _buildMultiSelect({
    required String label,
    required List<String> items,
    required List<String> selectedList,
    required Function(List<String>) onSelectionChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        InkWell(
          onTap: () async {
            final List<String>? results = await showDialog(
              context: context,
              builder: (context) {
                List<String> tempSelected = List.from(selectedList);
                return StatefulBuilder(
                  builder: (context, setStateDialog) {
                    return AlertDialog(
                      title: Text("Select $label"),
                      content: SingleChildScrollView(
                        child: Column(
                          children: items.map((item) {
                            return CheckboxListTile(
                              value: tempSelected.contains(item),
                              title: Text(item),
                              onChanged: (val) {
                                setStateDialog(() {
                                  if (val == true) {
                                    tempSelected.add(item);
                                  } else {
                                    tempSelected.remove(item);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, null),
                          child: const Text("Cancel"),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context, tempSelected),
                          child: const Text("Done"),
                        ),
                      ],
                    );
                  },
                );
              },
            );

            if (results != null) {
              setState(() => onSelectionChanged(results));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedList.isEmpty
                        ? "Select $label"
                        : selectedList.join(", "),
                    style: TextStyle(
                      color: selectedList.isEmpty ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: selectedList.map((item) {
            return Chip(
              label: Text(item),
              backgroundColor: Colors.brown.shade200,
              deleteIcon: const Icon(Icons.close, size: 16),
              onDeleted: () {
                setState(() => selectedList.remove(item));
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
      backgroundColor: const Color(0xFFFDF5EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF5EE),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Market Opportunity",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Step 2 of 5",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 8),
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Step 2
              _buildMultiSelect(
                label: "Industry / Sector Tags",
                items: _industryTags,
                selectedList: _selectedIndustries,
                onSelectionChanged: (list) => _selectedIndustries = list,
              ),
              _buildMultiSelect(
                label: "Geography Target",
                items: _geographyTargets,
                selectedList: _selectedGeographies,
                onSelectionChanged: (list) => _selectedGeographies = list,
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
                      label: "TAM",
                      controller: _tamController,
                      hint: "\$1B",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      label: "SAM",
                      controller: _samController,
                      hint: "\$100M",
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: "SOM",
                      controller: _somController,
                      hint: "\$10M",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      label: "Market Growth Rate",
                      controller: _marketGrowthController,
                      hint: "e.g., 15% CAGR",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Business Model
              const Text(
                "Business Model",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildMultiSelect(
                label: "Revenue Streams",
                items: _revenueStreams,
                selectedList: _selectedRevenueStreams,
                onSelectionChanged: (list) => _selectedRevenueStreams = list,
              ),
              _buildTextField(
                label: "Current Pricing Example",
                controller: _pricingController,
                hint: "e.g., \$99/month Pro Plan",
              ),
              _buildMultiSelect(
                label: "Distribution Channels",
                items: _distributionChannels,
                selectedList: _selectedChannels,
                onSelectionChanged: (list) => _selectedChannels = list,
              ),
              _buildTextField(
                label: "Go-To-Market Strategy",
                controller: _goToMarketController,
                hint: "Describe your strategy",
                maxLines: 4,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: const Color(0xFFFDF5EE),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.brown.shade200),
                ),
                child: const Text(
                  'Save Draft',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade200,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
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
