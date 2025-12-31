class SignupModel {
  final String id;
  final String name;
  final String semester;
  final String course;


  SignupModel({
    required this.id,
    required this.name,
    required this.semester,
    required this.course,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json){
    return SignupModel(id: json['id'],
                       name: json['name'],
                       semester: json['semester'],
                       course: json['course']);
  }
  Map<String , dynamic >tojson() {
    return {
      'id': id,
      'name': name,
      'semester': semester,
      'course': course,
    };
  }

}