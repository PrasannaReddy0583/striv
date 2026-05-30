class DocumentItem {
  final String title;
  final String fileType;
  final String fileSize;
  final bool isLocked;

  DocumentItem({
    required this.title,
    required this.fileType,
    required this.fileSize,
    this.isLocked = true,
  });
}

class DocumentSection {
  final String sectionTitle;
  final List<DocumentItem> documents;

  DocumentSection({
    required this.sectionTitle,
    required this.documents,
  });
}

class DataRoomModel {
  final String title;
  final String accessStatus;
  final bool isAccessGranted;
  final List<DocumentSection> sections;

  DataRoomModel({
    required this.title,
    required this.accessStatus,
    required this.isAccessGranted,
    required this.sections,
  });

  static DataRoomModel getSampleData() {
    return DataRoomModel(
      title: 'Secure Data Room',
      accessStatus: 'NDA Signed - Access Granted',
      isAccessGranted: true,
      sections: [
        DocumentSection(
          sectionTitle: 'Financials',
          documents: [
            DocumentItem(
              title: 'Financial Projections 2024-2026',
              fileType: 'PDF',
              fileSize: '2 MB',
            ),
            DocumentItem(
              title: 'Cap Table',
              fileType: 'XLS',
              fileSize: '500 KB',
            ),
          ],
        ),
        DocumentSection(
          sectionTitle: 'Legal Documents',
          documents: [
            DocumentItem(
              title: 'Term Sheet',
              fileType: 'PDF',
              fileSize: '1.2 MB',
            ),
            DocumentItem(
              title: 'Shareholder Agreement',
              fileType: 'PDF',
              fileSize: '3.5 MB',
            ),
          ],
        ),
        DocumentSection(
          sectionTitle: 'Customer Contracts',
          documents: [
            DocumentItem(
              title: 'Sample Customer Contract',
              fileType: 'PDF',
              fileSize: '900 KB',
            ),
          ],
        ),
        DocumentSection(
          sectionTitle: 'IP Filings',
          documents: [
            DocumentItem(
              title: 'Patent Application',
              fileType: 'PDF',
              fileSize: '2.1 MB',
            ),
          ],
        ),
      ],
    );
  }
}