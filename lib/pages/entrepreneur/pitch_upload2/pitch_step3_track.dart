import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:striv/pages/entrepreneur/pitch_upload2/pitch_step4.dart';

class TractionKPIsForm extends StatefulWidget {
  final Map<String, dynamic>? previousData;

  const TractionKPIsForm({
    super.key,
    this.previousData,
    required Map<String, dynamic> data,
  });

  @override
  State<TractionKPIsForm> createState() => _TractionKPIsFormState();
}

class _TractionKPIsFormState extends State<TractionKPIsForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _customersController = TextEditingController();
  final TextEditingController _revenueController = TextEditingController();
  final TextEditingController _metricValueController = TextEditingController();
  final TextEditingController _milestoneDescController =
      TextEditingController();
  final TextEditingController _valuationController = TextEditingController();
  final TextEditingController _revenueHistoryController =
      TextEditingController();
  final TextEditingController _expensesController = TextEditingController();
  final TextEditingController _runwayController = TextEditingController();
  final TextEditingController _prevAmountController = TextEditingController();
  final TextEditingController _prevInvestorsController =
      TextEditingController();
  final TextEditingController _prevTypeController = TextEditingController();

  final List<String> _growthMetrics = [
    'MAU',
    'CAC',
    'Retention',
    'DAU',
    'LTV',
    'Churn',
  ];
  final Set<String> _selectedMetrics = {};

  DateTime? _milestoneDate;

  String? _tractionFileName;
  String? _financialFileName;

  @override
  void dispose() {
    _customersController.dispose();
    _revenueController.dispose();
    _metricValueController.dispose();
    _milestoneDescController.dispose();
    _valuationController.dispose();
    _revenueHistoryController.dispose();
    _expensesController.dispose();
    _runwayController.dispose();
    _prevAmountController.dispose();
    _prevInvestorsController.dispose();
    _prevTypeController.dispose();
    super.dispose();
  }

  Future<void> _pickFile({required bool isTraction}) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx', 'pptx', 'xlsx'],
      );

      if (result != null && result.files.isNotEmpty) {
        final name = result.files.first.name;
        setState(() {
          if (isTraction) {
            _tractionFileName = name;
          } else {
            _financialFileName = name;
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to pick file: $e')));
    }
  }

  Future<void> _pickMilestoneDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _milestoneDate ?? now,
      firstDate: DateTime(now.year - 15),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {
        _milestoneDate = picked;
      });
    }
  }

  String _formatDate(DateTime d) {
    return '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';
  }

  void _toggleMetric(String metric) {
    setState(() {
      if (_selectedMetrics.contains(metric)) {
        _selectedMetrics.remove(metric);
      } else {
        _selectedMetrics.add(metric);
      }
    });
  }

  void _saveDraft() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Draft saved')));
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final merged = {
        ...?widget.previousData,
        'currentCustomers': _customersController.text.trim(),
        'revenueMRRARR': _revenueController.text.trim(),
        'selectedMetrics': _selectedMetrics.toList(),
        'metricsValue': _metricValueController.text.trim(),
        'milestoneDescription': _milestoneDescController.text.trim(),
        'milestoneDate': _milestoneDate != null
            ? _formatDate(_milestoneDate!)
            : null,
        'tractionFile': _tractionFileName,
        'financials': {
          'valuation': _valuationController.text.trim(),
          'revenueHistory': _revenueHistoryController.text.trim(),
          'expenses': _expensesController.text.trim(),
          'runway': _runwayController.text.trim(),
        },
        'previousRound': {
          'amount': _prevAmountController.text.trim(),
          'investors': _prevInvestorsController.text.trim(),
          'type': _prevTypeController.text.trim(),
        },
        'financialDocs': _financialFileName,
      };

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => PitchFundScreen(data: merged)));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill required fields')));
    }
  }

  InputDecoration _pillDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.brown.shade300, width: 2),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 12),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _dashedUploadBox({
    required String label,
    required String subLabel,
    required VoidCallback onTap,
    String? fileName,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        color: Colors.grey.shade400,
        strokeWidth: 1.5,
        dashPattern: [6, 6],
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 22),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_box_outlined,
                size: 28,
                color: Colors.grey.shade700,
              ),
              SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                subLabel,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              if (fileName != null) ...[
                SizedBox(height: 8),
                Text(
                  fileName,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = Color(0xFFFDF5EE);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Pitch Deck',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(54),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Step 3 of 5',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
                SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 3 / 5,
                    minHeight: 6,
                    backgroundColor: Colors.brown.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.brown.shade300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 8),
                Text(
                  'Traction & KPIs',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 12),

                // Current Customers
                TextFormField(
                  controller: _customersController,
                  decoration: _pillDecoration(hint: 'Current Customers/Users'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12),

                // Revenue
                TextFormField(
                  controller: _revenueController,
                  decoration: _pillDecoration(hint: 'Revenue (MRR/ARR)'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 18),

                // Growth Metrics
                _sectionTitle('Growth Metrics'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _growthMetrics.map((m) {
                    final selected = _selectedMetrics.contains(m);
                    return FilterChip(
                      label: Text(m),
                      selected: selected,
                      onSelected: (_) => _toggleMetric(m),
                      selectedColor: Colors.brown.shade200.withOpacity(0.6),
                      checkmarkColor: Colors.white,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12),

                // Metric Value
                TextFormField(
                  controller: _metricValueController,
                  decoration: _pillDecoration(
                    hint: 'Value for selected metrics',
                  ),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 18),

                // Milestones
                _sectionTitle('Milestones Achieved'),
                TextFormField(
                  controller: _milestoneDescController,
                  maxLines: 4,
                  decoration: _pillDecoration(hint: 'Description'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12),

                // Milestone Date Picker
                GestureDetector(
                  onTap: _pickMilestoneDate,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _milestoneDate == null
                                ? 'mm/dd/yyyy'
                                : _formatDate(_milestoneDate!),
                            style: TextStyle(
                              color: _milestoneDate == null
                                  ? Colors.grey
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18),

                // Traction File Upload
                _dashedUploadBox(
                  label: 'Tap to upload file',
                  subLabel: 'PDF, DOCX, or PPTX (Max 10MB)',
                  onTap: () => _pickFile(isTraction: true),
                  fileName: _tractionFileName,
                ),
                SizedBox(height: 24),

                // Financials
                _sectionTitle('Financials'),
                TextFormField(
                  controller: _valuationController,
                  decoration: _pillDecoration(hint: 'Current Valuation'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _revenueHistoryController,
                  decoration: _pillDecoration(
                    hint: 'Revenue History (last 12 months)',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _expensesController,
                  decoration: _pillDecoration(hint: 'Expenses / Burn Rate'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _runwayController,
                  decoration: _pillDecoration(hint: 'Runway Left'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 20),

                // Previous Funding Rounds
                _sectionTitle('Previous Funding Rounds'),
                TextFormField(
                  controller: _prevAmountController,
                  decoration: _pillDecoration(hint: 'Amount'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _prevInvestorsController,
                  decoration: _pillDecoration(hint: 'Investor Names'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _prevTypeController,
                  decoration: _pillDecoration(hint: 'Type'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(height: 20),

                // Financial Docs Upload
                _dashedUploadBox(
                  label: 'Tap to upload documents',
                  subLabel: 'Balance sheets, P&L, etc.',
                  onTap: () => _pickFile(isTraction: false),
                  fileName: _financialFileName,
                ),
                SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: bg,
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _saveDraft,
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
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade300,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Next',
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

class TractionPreviewPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const TractionPreviewPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    Widget row(String k, dynamic v) => Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Text('$k: ${v ?? '-'}', style: TextStyle(fontSize: 14)),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Preview')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            row('Current Customers', data['currentCustomers']),
            row('Revenue (MRR/ARR)', data['revenueMRRARR']),
            row('Selected Metrics', (data['selectedMetrics'] ?? []).join(', ')),
            row('Metrics Value', data['metricsValue']),
            row('Milestone Desc', data['milestoneDescription']),
            row('Milestone Date', data['milestoneDate']),
            SizedBox(height: 12),
            row('Traction File', data['tractionFile']),
            SizedBox(height: 12),
            row('Valuation', data['financials']?['valuation']),
            row('Revenue History', data['financials']?['revenueHistory']),
            row('Expenses', data['financials']?['expenses']),
            row('Runway', data['financials']?['runway']),
            SizedBox(height: 12),
            row('Previous Round - Amount', data['previousRound']?['amount']),
            row(
              'Previous Round - Investors',
              data['previousRound']?['investors'],
            ),
            row('Previous Round - Type', data['previousRound']?['type']),
            SizedBox(height: 12),
            row('Financial Docs', data['financialDocs']),
          ],
        ),
      ),
    );
  }
}
