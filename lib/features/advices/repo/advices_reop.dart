import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medease1/core/networking/api_endpoints.dart';
import 'package:medease1/core/storage/storage_keys.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/features/advices/model/advices_model.dart';
import '../../../core/networking/dio_helper.dart';

class AdviceRepo {
  final DioHelper _dioHelper = DioHelper();
   final DioHelper dioHelper;

   AdviceRepo(this.dioHelper);

  Future<Either<String, List<AdvicesModel>>> getAdvices() async {
    try {
      final token = await sl<StorageHelper>().getData(key: "accesstoken");
      log('🔐 Token used in ProfileRepo: $token');

      final response = await dioHelper.getResponse(
        endpoint: ApiEndpoints.getAdvices,
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final advices = data.map((e) => AdvicesModel.fromJson(e)).toList();

        return right(advices);
      } else {
        return left('Error: ${response.statusCode}');
      }
    } catch (error) {
      return left(error.toString());
    }
  }
}