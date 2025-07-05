import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/utils/storage_helper.dart';
import 'package:medease1/features/advices/model/advices_model.dart';
import '../../../core/networking/dio_helper.dart';

class AdviceRepo {
  final DioHelper _dioHelper = DioHelper();
   final DioHelper dioHelper;

   AdviceRepo(this.dioHelper);

  Future<Response?> getAllAdvices() async {
    return await _dioHelper.getResponse(endpoint: ApiEndpoints.getAllAdvices);
  }

  Future<Response?> createAdvice({
    required String diseasesCategoryId,
    required String title,
  }) async {
    return await _dioHelper.postRequest(
      endpoint: ApiEndpoints.createAdvice,
      data: {
        "diseasesCategoryId": diseasesCategoryId,
        "title": title,
      },
    );
  }

  Future<Response?> createFullAdvice({
    required String diseasesCategoryId,
    required String title,
    required String description,
    required String doctorId,
    File? imageFile,
  }) async {
    FormData formData = FormData.fromMap({
      "diseasesCategoryId": diseasesCategoryId,
      "title": title,
      "description": description,
      "doctorId": doctorId,
      if (imageFile != null)
        "image": await MultipartFile.fromFile(imageFile.path),
    });

    return await DioHelper.dio!.post(ApiEndpoints.createFullAdvice, data: formData);
  }

  Future<Response?> createDislike({
    required String diseasesCategoryId,
    required String title,
    required String description,
    required String doctorId,
    File? imageFile,
  }) async {
    FormData formData = FormData.fromMap({
      "diseasesCategoryId": diseasesCategoryId,
      "title": title,
      "description": description,
      "doctorId": doctorId,
      if (imageFile != null)
        "image": await MultipartFile.fromFile(imageFile.path),
    });

    return await DioHelper.dio!.post(ApiEndpoints.createDislike, data: formData);
  }

  Future<Response?> updateAdvice({
    required String adviceId,
    required String diseasesCategoryId,
    required String title,
    required String description,
  }) async {
    return await DioHelper.dio!.patch(
      '${ApiEndpoints.updateAdvice}$adviceId',
      data: {
        "diseasesCategoryId": diseasesCategoryId,
        "title": title,
        "description": description,
      },
    );
  }

  Future<Response?> deleteAdvice(String adviceId) async {
    return await DioHelper.dio!.delete('${ApiEndpoints.deleteAdvice}$adviceId');
  }
}