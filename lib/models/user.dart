class User {
  final String id;
  final String name;
  final String photoUrl;
  // Add other fields as needed

  User({required this.id, required this.name, required this.photoUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'photoUrl': photoUrl,
      };
} 