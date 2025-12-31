import 'package:flutter/material.dart';
import 'package:unitrack/widget/MyText.dart';
// import '../../../DSA/Customized_Hashmap.dart';
import '../../../utils/theme_colors.dart';
// import '../../../DSA/Customized_Queue.dart';

class StudentFeesPage extends StatefulWidget {
  const StudentFeesPage({super.key});

  @override
  State<StudentFeesPage> createState() => _StudentFeesPageState();
}

class _StudentFeesPageState extends State<StudentFeesPage> {

  int _daysLeft(String? dueDate) {
    if (dueDate == null) return 99999;
    final due = DateTime.tryParse(dueDate);
    if (due == null) return 99999;
    final now = DateTime.now();
    return due.difference(now).inDays;
  }

  final List<Map<String, dynamic>> semesters = [
    {
      'semester': 'First Semester',
      'isPaid': false,
      'totalAmount': 20000,
      'paidAmount': 20000,
      'pendingAmount': 0,
      'paymentDate': '2024-08-15',
      'creditHours': 15,
      'receiptUrl': 'https://example.com/receipt1.pdf',
    },
    {
      'semester': 'Examination fee',
      'isPaid': false,
      'totalAmount': 22000,
      'paidAmount': 10000,
      'pendingAmount': 12000,
      'paymentDate': '2026-12-01',
      'creditHours': 16,
      'receiptUrl': 'https://example.com/receipt2.pdf',
    },
    {
      'semester': 'Third Semester',
      'isPaid': false,
      'totalAmount': 25000,
      'paidAmount': 0,
      'pendingAmount': 25000,
      'paymentDate': '2026-01-03',
      'creditHours': 18,
      'receiptUrl': null,
    },
    {
      'semester': 'Lab Charges',
      'isPaid': false,
      'totalAmount': 25000,
      'paidAmount': 0,
      'pendingAmount': 25000,
      'paymentDate': '2026-01-02',
      'creditHours': 18,
      'receiptUrl': null,
    },
    {
      'semester': 'Fourth Semester',
      'isPaid': false,
      'totalAmount': 25000,
      'paidAmount': 0,
      'pendingAmount': 25000,
      'paymentDate': '2026-02-01',
      'creditHours': 18,
      'receiptUrl': null,
    },
    {
      'semester': 'Fifth Semester',
      'isPaid': false,
      'totalAmount': 25000,
      'paidAmount': 0,
      'pendingAmount': 25000,
      'paymentDate': '2026-10-01',
      'creditHours': 18,
      'receiptUrl': null,
    },
    {
      'semester': 'Second Semester',
      'isPaid': false,
      'totalAmount': 25000,
      'paidAmount': 0,
      'pendingAmount': 25000,
      'paymentDate': '2025-05-10',
      'creditHours': 18,
      'receiptUrl': null,
    },
  ];


  List<Map<String, dynamic>> sortedFeeList = [];

  @override
  void initState() {
    super.initState();

    sortedFeeList = List.from(semesters);
    sortedFeeList.sort((a, b) {
      int daysA = _daysLeft(a['paymentDate']);
      int daysB = _daysLeft(b['paymentDate']);
      return daysA.compareTo(daysB);
    });
  }

  Color feecolor(String? date) {
    int daysLeft = _daysLeft(date);
    if (daysLeft < 0) {
      return Colors.red.shade700;
    } else if (daysLeft <= 4) {
      return Colors.orange.shade300;
    } else {
      return Colors.green.shade700;
    }
  }



  @override
  Widget build(BuildContext context) {
    // We no longer need to call getQueueAsList() in the build method.
    // final List<Map<String, dynamic>> feeList = getQueueAsList();

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

          itemCount: sortedFeeList.length,
          itemBuilder: (context, index) {

            final sem = sortedFeeList[index];

            return Card(
              color: feecolor(sem['paymentDate']),
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
                      text: sem['pendingAmount'] == 0
                          ? 'Fees Paid'
                          : 'Fees Pending',
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.primary,
                    ),
                    trailing: CustomText(
                      text: 'Due Date: ${sem['paymentDate'] ?? 'N/A'}',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,

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
}
