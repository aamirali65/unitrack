class Student {
  final String id;
  final String name;
  final String semester;
  final String course;
  final String email;

  Student({
    required this.id,
    required this.name,
    required this.semester,
    required this.course,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      semester: json['semester'],
      course: json['course'],
      email: json['email'] ?? '',
    );
  }
}
