class UpdateUserDto {
  String? fullName;
  String? email;
  String? username;
  String? password;
  String? bio;
  String? avatarUrl;
  bool? isActive;
  String? otp;
  DateTime? otpGeneratedTime;

  UpdateUserDto({
    this.fullName,
    this.email,
    this.username,
    this.password,
    this.bio,
    this.avatarUrl,
    this.isActive,
    this.otp,
    this.otpGeneratedTime,
  });

  // Convert từ JSON (nếu BE trả về)
  factory UpdateUserDto.fromJson(Map<String, dynamic> json) {
    return UpdateUserDto(
      fullName: json['fullName'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      bio: json['bio'],
      avatarUrl: json['avatarUrl'],
      isActive: json['isActive'],
      otp: json['otp'],
      otpGeneratedTime: json['otpGeneratedTime'] != null
          ? DateTime.parse(json['otpGeneratedTime'])
          : null,
    );
  }

  // Convert sang JSON để gửi lên API
  Map<String, dynamic> toJson() {
    return {
      if (fullName != null) 'fullName': fullName,
      if (email != null) 'email': email,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (bio != null) 'bio': bio,
      if (avatarUrl != null) 'avatarUrl': avatarUrl,
      if (isActive != null) 'isActive': isActive,
      if (otp != null) 'otp': otp,
      if (otpGeneratedTime != null)
        'otpGeneratedTime': otpGeneratedTime!.toIso8601String(),
    };
  }
}
