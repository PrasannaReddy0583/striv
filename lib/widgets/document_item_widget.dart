import 'package:flutter/material.dart';
import '../models/data_room_model.dart';

class DocumentItemWidget extends StatelessWidget {
  final DocumentItem document;
  final VoidCallback onTap;

  const DocumentItemWidget({
    super.key,
    required this.document,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.008,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.005,
        ),
        leading: Container(
          width: MediaQuery.of(context).size.width * 0.08,
          height: MediaQuery.of(context).size.width * 0.08,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            document.isLocked ? Icons.lock_outline : Icons.description_outlined,
            size: MediaQuery.of(context).size.width * 0.045,
            color: Colors.black,
          ),
        ),
        title: Text(
          document.title,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.035,
            fontWeight: FontWeight.w800,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          '${document.fileType} • ${document.fileSize}',
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: MediaQuery.of(context).size.width * 0.03,
            color: Colors.grey[600],
          ),
        ),
        trailing: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03,
              vertical: MediaQuery.of(context).size.height * 0.006,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3CD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'View',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.w800,
                color: const Color.fromARGB(255, 222, 180, 56),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
