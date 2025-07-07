class Student {
  final String id;
  final String name;
  final String nis;
  final String className;

  Student({
    required this.id,
    required this.name,
    required this.nis,
    required this.className,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      nis: json['nis'],
      className: json['class_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nis': nis,
      'class_name': className,
    };
  }
} 