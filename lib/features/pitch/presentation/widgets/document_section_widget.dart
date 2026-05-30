import 'package:flutter/material.dart';
import 'package:striv/features/pitch/data/models/data_room_model.dart';
import 'document_item_widget.dart';

class DocumentSectionWidget extends StatelessWidget {
  final DocumentSection section;
  final Function(DocumentItem) onDocumentTap;

  const DocumentSectionWidget({
    super.key,
    required this.section,
    required this.onDocumentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.012,
          ),
          child: Text(
            section.sectionTitle,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ),
        ...section.documents.map((document) => 
          DocumentItemWidget(
            document: document,
            onTap: () => onDocumentTap(document),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.025),
      ],
    );
  }
}