import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:striv/features/pitch/presentation/pages/upload/pitch_step5.dart';

class PitchFundScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const PitchFundScreen({super.key, required this.data});

  @override
  State<PitchFundScreen> createState() => _PitchFundScreenState();
}

class _PitchFundScreenState extends State<PitchFundScreen> {
  final _amountController = TextEditingController();
  final _equityController = TextEditingController();
  final _patentsController = TextEditingController();
  final _trademarksController = TextEditingController();
  final _useOfFundsController = TextEditingController();
  final _milestonesController = TextEditingController();

  String _selectedCurrency = 'USD';
  String _selectedFundingType = 'Seed Round';
  String _selectedLicense = 'FDA Approval';
  int _selectedLegalDeclaration = 0;
  String? _uploadedFileName;

  // Default placeholder values
  final String defaultAmount = '100,000';
  final String defaultEquity = '10';
  final String defaultUseOfFunds =
      'Marketing, Product Development, Team Expansion';
  final String defaultMilestones =
      'Launch MVP, Secure First 1000 Users, Achieve Profitability';

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'png', 'jpg', 'jpeg'],
      );

      if (result != null) {
        setState(() => _uploadedFileName = result.files.single.name);
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error picking file. Please try again.',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: Colors.red,
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
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.poppins(fontSize: 16),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.brown.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.brown.shade300, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.brown.shade200),
          ),
          child: DropdownButtonFormField<String>(
            initialValue: value,
            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black87),
            decoration: const InputDecoration(border: InputBorder.none),
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: GoogleFonts.poppins()),
                  ),
                )
                .toList(),
            onChanged: (val) => onChanged(val!),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioOption(int value, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Radio<int>(
          value: value,
          groupValue: _selectedLegalDeclaration,
          onChanged: (val) => setState(() => _selectedLegalDeclaration = val!),
          activeColor: Colors.brown.shade300,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _submit() {
    // Use default values if controller is empty
    final amount = _amountController.text.trim().isEmpty
        ? defaultAmount
        : _amountController.text.trim();
    final equity = _equityController.text.trim().isEmpty
        ? defaultEquity
        : _equityController.text.trim();
    final useOfFunds = _useOfFundsController.text.trim().isEmpty
        ? defaultUseOfFunds
        : _useOfFundsController.text.trim();
    final milestones = _milestonesController.text.trim().isEmpty
        ? defaultMilestones
        : _milestonesController.text.trim();

    final merged = {
      ...widget.data,
      'fundingRequest': {
        'amount': amount,
        'currency': _selectedCurrency,
        'fundingType': _selectedFundingType,
        'equityOffered': equity,
        'useOfFunds': useOfFunds,
        'expectedMilestones': milestones,
      },
      'legalAndIP': {
        'patents': _patentsController.text.trim(),
        'trademarks': _trademarksController.text.trim(),
        'license': _selectedLicense,
      },
      'companyDocs': _uploadedFileName,
      'legalDeclaration': _selectedLegalDeclaration,
    };

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => Pitch_secure(data: merged)));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _equityController.dispose();
    _patentsController.dispose();
    _trademarksController.dispose();
    _useOfFundsController.dispose();
    _milestonesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF5EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF5EE),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Pitch Deck Upload',
          style: GoogleFonts.poppins(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Step 4 of 5',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 0.6,
                  backgroundColor: Colors.grey.shade300,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.brown.shade300,
                  ),
                  minHeight: 4,
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Funding Request',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'Amount',
                          controller: _amountController,
                          hint: defaultAmount,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildDropdown(
                          label: 'Currency',
                          value: _selectedCurrency,
                          items: ['USD', 'EUR', 'GBP', 'INR'],
                          onChanged: (val) =>
                              setState(() => _selectedCurrency = val),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDropdown(
                    label: 'Type of Funding',
                    value: _selectedFundingType,
                    items: ['Seed Round', 'Series A', 'Series B', 'Series C'],
                    onChanged: (val) =>
                        setState(() => _selectedFundingType = val),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Equity/Dilution Offered (%)',
                    controller: _equityController,
                    hint: defaultEquity,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Use of Funds',
                    controller: _useOfFundsController,
                    maxLines: 3,
                    hint: defaultUseOfFunds,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    label: 'Expected Milestones With Funding',
                    controller: _milestonesController,
                    maxLines: 3,
                    hint: defaultMilestones,
                  ),
                  const SizedBox(height: 30),

                  // Legal & IP
                  Text(
                    'Legal & IP',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          label: 'Patents Filed',
                          controller: _patentsController,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          label: 'Trademark Registered',
                          controller: _trademarksController,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDropdown(
                    label: 'Licenses/Certifications',
                    value: _selectedLicense,
                    items: [
                      'FDA Approval',
                      'ISO Certification',
                      'CE Marking',
                      'Other',
                    ],
                    onChanged: (val) => setState(() => _selectedLicense = val),
                  ),
                  const SizedBox(height: 20),

                  // Company Docs
                  Text(
                    'Company Incorporation Docs',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickFile,
                    child: DottedBorder(
                      color: Colors.brown.shade300,
                      strokeWidth: 1.5,
                      dashPattern: const [6, 4],
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 235, 203, 172),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: _uploadedFileName == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.cloud_upload_outlined,
                                      size: 32,
                                      color: Colors.brown.shade400,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Upload a file or drag and drop',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: Colors.brown.shade400,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'PDF, DOCX, PNG, JPG up to 10MB',
                                      style: GoogleFonts.poppins(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _uploadedFileName!,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Tap to change file',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.brown.shade300,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Legal Declarations
                  Text(
                    'Founder Legal Declarations',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildRadioOption(
                    0,
                    'No pending litigation against the company.',
                  ),
                  _buildRadioOption(
                    1,
                    'All intellectual property rights are fully owned by the company.',
                  ),
                  _buildRadioOption(
                    2,
                    'Founders have no prior legal issues related to business practices.',
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFFDF5EE),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(color: Colors.brown.shade200),
                    ),
                    child: Text(
                      'Save Draft',
                      style: GoogleFonts.poppins(
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
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown.shade300,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Next',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
