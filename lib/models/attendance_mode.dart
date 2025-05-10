class AttendanceMode {
  final int id;
  final String name;

  AttendanceMode({required this.id, required this.name});

  factory AttendanceMode.fromJson(Map<String, dynamic> json) {
    return AttendanceMode(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
} 