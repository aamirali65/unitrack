class AttendanceNode {
  final int week;
  final bool present;

  AttendanceNode({
    required this.week,
    required this.present,
  });

  factory AttendanceNode.fromJson(Map<String, dynamic> json) {
    return AttendanceNode(
      week: json['week'],
      present: json['present'],
    );
  }
}
