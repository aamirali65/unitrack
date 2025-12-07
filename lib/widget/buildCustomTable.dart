import 'package:flutter/material.dart';
import 'package:unitrack/utils/theme_colors.dart';

class CustomTable extends StatelessWidget {
  final List<Map<String, String>> rows;
  final String col1;
  final String col2;
  final String key1;
  final String key2;

  const CustomTable({
    super.key,
    required this.rows,
    required this.col1,
    required this.col2,
    required this.key1,
    required this.key2,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      shadowColor: Colors.black.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Table(
          border: TableBorder.all(color: Colors.grey.shade300, width: 1.5),
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(3),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey.shade100),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    col1,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ThemeColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    col2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ThemeColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            ...rows.map((e) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      e[key1] ?? '',
                      style: TextStyle(fontSize: 14, color: ThemeColors.primary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      e[key2] ?? '',
                      style: TextStyle(fontSize: 14, color: ThemeColors.primary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
