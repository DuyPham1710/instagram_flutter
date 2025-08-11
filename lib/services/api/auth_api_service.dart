import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/routes.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';
import 'package:instagram_flutter/dto/create_user_dto.dart';
import 'package:instagram_flutter/dto/login_dto.dart';
import 'package:instagram_flutter/dto/verify_account_dto.dart';

class AuthApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> login(LoginDto loginDto) async {
    try {
      final response = await dio.post(Routes.login, data: loginDto.toJson());
      return response;
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  Future<dynamic> register(CreateUserDto userData) async {
    try {
      final response = await dio.post(Routes.register, data: userData);
      return response;
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  Future<dynamic> verifyAccount(VerifyAccountDto verifyAccountDto) async {
    try {
      final response = await dio.patch(
        Routes.verifyAccount,
        data: verifyAccountDto.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  Future<dynamic> resendOtp(String email) async {
    try {
      final response = await dio.patch(
        Routes.resendOtp,
        data: {'email': email},
      );
      return response;
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  // Future<dynamic> getUserProfile() async {
  //   try {
  //     final response = await dio.get(ApiPath.userProfile);
  //     return response.data;
  //   } on DioException catch (e) {
  //     throw Exception(e.response?.data ?? 'Failed to get profile');
  //   }
  // }
}
