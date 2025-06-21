class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String role;
  final String status;
  final String token; // <-- Add this line

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.role,
    required this.status,
    required this.token, // <-- Add this line
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toString() ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      token: json['token'] ?? '', // <-- Add this line
    );
  }
}