import 'dart:io';

import 'package:dio/dio.dart';
import 'package:instagram_flutter/apps/config/routes.dart';
import 'package:instagram_flutter/apps/config/dio_client.dart';
import 'package:instagram_flutter/dto/update_user_dto.dart';

class UserApiService {
  final Dio dio = DioClient().dio;

  Future<dynamic> getProfile() async {
    try {
      final response = await dio.get(Routes.userProfile);
      //print('Response: ${response.data}');
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get profile');
    }
  }

  Future<dynamic> getAllUsersOther() async {
    try {
      final response = await dio.get(Routes.allUsersOther);
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Failed to get all users');
    }
  }

  Future<dynamic> updateProfile(UpdateUserDto data, {File? avatarFile}) async {
    try {
      final formData = FormData.fromMap({
        "fullName": data.fullName,
        "username": data.username,
        "bio": data.bio,
        if (avatarFile != null)
          "file": await MultipartFile.fromFile(
            avatarFile.path,
            filename: avatarFile.path.split('/').last,
          ),
      });

      final response = await dio.patch(
        Routes.user,
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
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
}
