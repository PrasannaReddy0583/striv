import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:striv/pages/entrepreneur/pitch_upload2/pitch_step2_upload.dart';

class ProblemSolutionForm extends StatefulWidget {
  const ProblemSolutionForm({super.key});

  @override
  State<ProblemSolutionForm> createState() => _ProblemSolutionFormState();
}

class _ProblemSolutionFormState extends State<ProblemSolutionForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oneLinerController = TextEditingController();
  final TextEditingController _detailedProblemController =
      TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyTaglineController =
      TextEditingController();

  String? _evidenceFile;
  String? _pitchDeckFile;
  String? _logo;
  String? _card;
  String? _videoPitchFile;
  String? _selectedRole;

  @override
  void dispose() {
    _oneLinerController.dispose();
    _detailedProblemController.dispose();
    _productDescriptionController.dispose();
    _companyNameController.dispose();
    _companyTaglineController.dispose();
    super.dispose();
  }

  Future<void> _pickFile(String type) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'pptx', 'docx', 'mp3', 'mp4', 'xlsx'],
      );

      if (result != null && result.files.isNotEmpty) {
        final name = result.files.first.name;
        setState(() {
          if (type == "evidence") {
            _evidenceFile = name;
          } else if (type == "pitchDeck") {
            _pitchDeckFile = name;
          } else if (type == "videoPitch") {
            _videoPitchFile = name;
          } else if (type == "logo") {
            _logo = name;
          } else if (type == "card") {
            _card = name;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to pick the file: $e')));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final step1Data = {
        "oneLiner": _oneLinerController.text.trim(),
        "detailedProblem": _detailedProblemController.text.trim(),
        "evidence": _evidenceFile ?? "No evidence uploaded",
        "productDescription": _productDescriptionController.text.trim(),
        "pitchDeck": _pitchDeckFile ?? "No pitch deck uploaded",
        "Logo": _logo ?? "No logo uploaded",
        "card": _card ?? "No card uploaded",
        "videoPitch": _videoPitchFile ?? "No video pitch uploaded",
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MarketOpportunityForm(step1Data: step1Data),
        ),
      );
    }
  }

  Widget _uploadBox({
    required String label,
    required String hint,
    required IconData icon,
    required VoidCallback onTap,
    String? fileName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(width: 4),
            Icon(Icons.info_outline, size: 16, color: Colors.grey),
          ],
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: DottedBorder(
            color: Colors.brown.shade300,
            strokeWidth: 1.5,
            dashPattern: [6, 4],
            borderType: BorderType.RRect,
            radius: Radius.circular(12),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFF7EADE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: fileName == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, size: 32, color: Colors.brown.shade400),
                          SizedBox(height: 8),
                          Text(
                            hint,
                            style: TextStyle(color: Colors.brown, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    : Text(
                        "Uploaded: $fileName",
                        style: TextStyle(color: Colors.black),
                      ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction, // ✅ auto validation
      validator: (val) => val == null || val.isEmpty ? "Required" : null,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.brown.shade300, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(12),
      ),
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
          "Problem & Solution",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Role Selection
              Text(
                "What is your role?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Column(
                children: [
                  RadioListTile<String>(
                    title: Text("A"),
                    value: "A",
                    groupValue: _selectedRole,
                    onChanged: (value) {
                      setState(() => _selectedRole = value);
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("B"),
                    value: "B",
                    groupValue: _selectedRole,
                    onChanged: (value) {
                      setState(() => _selectedRole = value);
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("C"),
                    value: "C",
                    groupValue: _selectedRole,
                    onChanged: (value) {
                      setState(() => _selectedRole = value);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),

              // One-liner
              Text(
                "1-Liner Problem Statement",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6),
              _buildTextFormField(
                controller: _oneLinerController,
                hint: "Briefly describe the problem",
              ),

              // Detailed Problem
              Text(
                "Detailed Problem",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6),
              _buildTextFormField(
                controller: _detailedProblemController,
                hint: "Provide a comprehensive description of the problem",
                maxLines: 5,
              ),

              // Evidence Upload
              _uploadBox(
                label: "Evidence of Problem",
                hint: "Upload market research, user feedback, etc.",
                icon: Icons.cloud_upload_outlined,
                fileName: _evidenceFile,
                onTap: () => _pickFile("evidence"),
              ),

              // Product Description
              Text(
                "Product Description",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 6),
              _buildTextFormField(
                controller: _productDescriptionController,
                hint: "Describe your product or solution",
                maxLines: 4,
              ),

              SizedBox(height: 30),

              // Pitch Deck & Video Pitch
              _uploadBox(
                label: "Pitch Deck (PDF/PPT)",
                hint: "Tap to upload your Pitch Deck",
                icon: Icons.insert_drive_file_outlined,
                fileName: _pitchDeckFile,
                onTap: () => _pickFile("pitchDeck"),
              ),
              _uploadBox(
                label: "Video Pitch (MP4)",
                hint: "Tap to upload your Video Pitch",
                icon: Icons.play_circle_outline,
                fileName: _videoPitchFile,
                onTap: () => _pickFile("videoPitch"),
              ),

              // Company Details
              _uploadBox(
                label: "Company Logo (PNG/JPG)",
                hint: "Tap to upload your Logo",
                icon: Icons.insert_drive_file_outlined,
                fileName: _logo,
                onTap: () => _pickFile("logo"),
              ),
              Text(
                "Company Name",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              _buildTextFormField(
                controller: _companyNameController,
                hint: "Company Name",
              ),
              SizedBox(height: 12),
              Text(
                "Company TagLine",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 12),
              _buildTextFormField(
                controller: _companyTaglineController,
                hint: "Company Tagline",
              ),
              SizedBox(height: 12),
              _uploadBox(
                label: "Company visit Card",
                hint: "Tap to upload your Card",
                icon: Icons.insert_drive_file_outlined,
                fileName: _card,
                onTap: () => _pickFile("Card"),
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
