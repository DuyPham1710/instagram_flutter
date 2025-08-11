class CreateUserDto {
  final String fullName;
  final String? bio;
  final String? avatarUrl;
  final String email;
  final String username;
  final String password;

  CreateUserDto({
    required this.fullName,
    this.bio,
    this.avatarUrl,
    required this.email,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "bio": bio,
    "avatarUrl": avatarUrl,
    "email": email,
    "username": username,
    "password": password,
  };
}
