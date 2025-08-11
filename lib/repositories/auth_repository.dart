import 'package:instagram_flutter/dto/create_user_dto.dart';
import 'package:instagram_flutter/dto/login_dto.dart';
import 'package:instagram_flutter/dto/user_response_dto.dart';
import 'package:instagram_flutter/dto/verify_account_dto.dart';
import 'package:instagram_flutter/services/api/auth_api_service.dart';

class AuthRepository {
  final AuthApiService authApiService;

  AuthRepository({required this.authApiService});

  Future<String> loginUser(LoginDto loginDto) async {
    final response = await authApiService.login(loginDto);
    // print('>>> check response: ${response.data}');
    // if (response.statusCode != 201) {
    //   throw DioException(
    //     requestOptions: response.requestOptions,
    //     response: response,
    //     type: DioExceptionType.badResponse,
    //   );
    // }
    return response.data['token'];
  }

  Future<UserResponseDto> registerUser(CreateUserDto userData) async {
    final response = await authApiService.register(userData);
    return UserResponseDto.fromJson(response.data);
  }

  Future<UserResponseDto> verifyUser(VerifyAccountDto verifyAccountDto) async {
    final response = await authApiService.verifyAccount(verifyAccountDto);
    return UserResponseDto.fromJson(response.data);
  }

  Future<String> resendOtp(String email) async {
    final response = await authApiService.resendOtp(email);
    return response.data['message'];
  }
}
