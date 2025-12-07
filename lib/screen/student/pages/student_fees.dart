import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
import '../../../utils/theme_colors.dart';

class StudentFeesPage extends StatefulWidget {
  const StudentFeesPage({super.key});

  @override
  State<StudentFeesPage> createState() => _StudentFeesPageState();
}

class _StudentFeesPageState extends State<StudentFeesPage> {
  final List<Map<String, dynamic>> semesters = [
    {
      'semester': 'First Semester',
      'isPaid': true,
      'totalAmount': 20000,
      'paidAmount': 20000,
      'pendingAmount': 0,
      'paymentDate': '2024-08-15',
      'creditHours': 15,
      'receiptUrl': 'https://example.com/receipt1.pdf',
    },
    {
      'semester': 'Second Semester',
      'isPaid': false,
      'totalAmount': 22000,
      'paidAmount': 10000,
      'pendingAmount': 12000,
      'paymentDate': '2024-12-01',
      'creditHours': 16,
      'receiptUrl': 'https://example.com/receipt2.pdf',
    },
    {
      'semester': 'Third Semester',
      'isPaid': false,
      'totalAmount': 25000,
      'paidAmount': 0,
      'pendingAmount': 25000,
      'paymentDate': null,
      'creditHours': 18,
      'receiptUrl': null,
    },
  ];

  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    // +1 for total fees card
    _expanded = List.generate(semesters.length + 1, (index) => false);
  }

  void _downloadReceipt(String? url) {
    if (url == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Receipt not available')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading receipt from $url')),
    );
  }

  // Calculate total fees from semesters
  Map<String, double> _calculateTotalFees() {
    double totalAmount = 0;
    double paidAmount = 0;
    double pendingAmount = 0;
    double creditHours = 0;

    for (var sem in semesters) {
      totalAmount += (sem['totalAmount'] ?? 0);
      paidAmount += (sem['paidAmount'] ?? 0);
      pendingAmount += (sem['pendingAmount'] ?? 0);
      creditHours += (sem['creditHours'] ?? 0);
    }

    return {
      'totalAmount': totalAmount,
      'paidAmount': paidAmount,
      'pendingAmount': pendingAmount,
      'creditHours': creditHours,
    };
  }

  @override
  Widget build(BuildContext context) {
    final totalFees = _calculateTotalFees();

    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: 'Fees Status',
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        centerTitle: true,
        backgroundColor: ThemeColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: semesters.length + 1,
          itemBuilder: (context, index) {
            // First card is total fees summary
            if (index == 0) {
              final isExpanded = _expanded[0];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: ThemeColors.primary,
                    width: 1.5,
                  ),
                ),
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    ListTile(
                      title: const CustomText(
                        text: 'Total Fees Paid',
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: ThemeColors.primary,
                      ),
                      subtitle: CustomText(
                        text: totalFees['pendingAmount'] == 0
                            ? 'All Fees Paid'
                            : 'Fees Pending',
                        fontWeight: FontWeight.w600,
                        color: ThemeColors.primary,
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _expanded[0] = !isExpanded;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          minimumSize: const Size(70, 36),
                        ),
                        child: CustomText(
                          text: isExpanded ? 'Hide' : 'Show',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRow('Total Amount', 'PKR ${totalFees['totalAmount']}'),
                            _buildRow('Paid Amount', 'PKR ${totalFees['paidAmount']}'),
                            _buildRow('Pending Amount', 'PKR ${totalFees['pendingAmount']}'),
                            _buildRow('Credit Hours', '${totalFees['creditHours']}'),
                            const SizedBox(height: 12),
                            // No receipt for total fees
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }

            // Other cards for each semester
            final sem = semesters[index - 1];
            final isExpanded = _expanded[index];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: ThemeColors.primary,
                  width: 1.5,
                ),
              ),
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  ListTile(
                    title: CustomText(
                      text: sem['semester'],
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: ThemeColors.primary,
                    ),
                    subtitle: CustomText(
                      text: sem['pendingAmount'] == 0 ? 'Fees Paid' : 'Fees Pending',
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.primary,
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _expanded[index] = !isExpanded;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(70, 36),
                      ),
                      child: CustomText(
                        text: isExpanded ? 'Hide' : 'Show',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRow('Total Amount', 'PKR ${sem['totalAmount']}'),
                          _buildRow('Paid Amount', 'PKR ${sem['paidAmount']}'),
                          _buildRow('Pending Amount', 'PKR ${sem['pendingAmount']}'),
                          _buildRow('Payment Date', sem['paymentDate'] ?? 'N/A'),
                          _buildRow('Credit Hours', '${sem['creditHours']}'),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () => _downloadReceipt(sem['receiptUrl']),
                              icon: const Icon(Icons.download),
                              label: const CustomText(text: 'Download Receipt', color: Colors.white),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
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
          },
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: CustomText(
              text: label,
              fontWeight: FontWeight.w600,
              color: ThemeColors.primary,
              fontSize: 15,
            ),
          ),
          Expanded(
            flex: 4,
            child: CustomText(
              text: value,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
