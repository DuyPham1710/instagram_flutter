class UserResponseDto {
  final int userId;
  final String fullName;
  final String email;
  final String username;
  final String? avatarUrl;
  final String? bio;
  final bool isActive;
  final DateTime createdAt;

  UserResponseDto({
    required this.userId,
    required this.fullName,
    required this.email,
    required this.username,
    this.avatarUrl,
    this.bio,
    required this.isActive,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'email': email,
      'username': username,
      'avatarUrl': avatarUrl,
      'bio': bio,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserResponseDto.fromJson(Map<String, dynamic> json) {
    return UserResponseDto(
      userId: json['userId'],
      fullName: json['fullName'],
      email: json['email'],
      username: json['username'],
      avatarUrl: json['avatarUrl'],
      bio: json['bio'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
