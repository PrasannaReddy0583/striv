import 'package:flutter/material.dart';
import '../models/data_room_model.dart';
import '../widgets/access_status_card.dart';
import '../widgets/document_section_widget.dart';
import '../widgets/action_button.dart';

class SecureDataRoomScreen extends StatefulWidget {
  const SecureDataRoomScreen({super.key});

  @override
  State<SecureDataRoomScreen> createState() => _SecureDataRoomScreenState();
}

class _SecureDataRoomScreenState extends State<SecureDataRoomScreen> {
  late DataRoomModel _dataRoomModel;

  @override
  void initState() {
    super.initState();
    _dataRoomModel = DataRoomModel.getSampleData();
  }

  void _onDocumentTap(DocumentItem document) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Opening ${document.title}...',
          style: TextStyle(fontFamily: "Poppins"),
        ),
        backgroundColor: Colors.teal,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onRequestClarification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Clarification request sent!',
          style: TextStyle(fontFamily: "Poppins"),
        ),
        backgroundColor: Colors.amber,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF4EB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Secure Data',
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccessStatusCard(
                status: _dataRoomModel.accessStatus,
                isGranted: _dataRoomModel.isAccessGranted,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // Document Sections
              ..._dataRoomModel.sections
                  .map(
                    (section) => DocumentSectionWidget(
                      section: section,
                      onDocumentTap: _onDocumentTap,
                    ),
                  )
                  .toList(),

              SizedBox(height: MediaQuery.of(context).size.height * 0.03),

              ActionButton(
                onPressed: _onRequestClarification,
                text: 'Request Clarification',
                backgroundColor: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
