class User {
  final int userId;
  final String fullName;
  final String? bio;
  final String? avatarUrl;
  final String email;
  final String username;
  final bool isActive;
  final DateTime createdAt;

  User({
    required this.userId,
    required this.fullName,
    this.bio,
    this.avatarUrl,
    required this.email,
    required this.username,
    required this.isActive,
    required this.createdAt,
  });
}
