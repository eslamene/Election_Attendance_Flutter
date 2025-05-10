class User {
  final String id;
  final String name;
  final String jobTitle;
  // Add other fields as needed

  User({required this.id, required this.name ,required this.jobTitle});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['referenceNumber'] as String,
      name: json['name'] as String,
      jobTitle: json['jobTitle']['titleName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
    'jobTitle':jobTitle
      };
} 