class VerifyAccountDto {
  final String email;
  final String otp;

  VerifyAccountDto({required this.email, required this.otp});

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }
}
