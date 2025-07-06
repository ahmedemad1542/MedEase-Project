import 'dart:io';

import 'package:dartz/dartz_streaming.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/core/storage/storage_helper.dart';
import 'package:medease1/core/utils/service_locator.dart';
import 'package:medease1/features/advices/cubit/advices_state.dart';
import 'package:medease1/features/advices/model/advices_model.dart';

import 'package:medease1/features/advices/repo/advices_repo.dart';

import '../../../core/storage/storage_keys.dart';

class AdviceCubit extends Cubit<AdviceState> {
  final AdviceRepo adviceRepo;

  AdviceCubit(this.adviceRepo) : super(AdviceInitial());
  List<String> categories = [];
  bool isPrevelliged = true;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String selectedCategory = '';

  Future<void> getAdvices() async {
    emit(AdviceLoading());
    isPrevelliged =
        await sl<StorageHelper>().getData(key: StorageKeys.role) == 'Admin' ||
        await sl<StorageHelper>().getData(key: StorageKeys.role) == 'Doctor';
    try {
      final response = await adviceRepo.getAllAdvices();
      final List<dynamic> data = response?.data['data'] ?? [];
      final advices = data.map((e) => AdviceModel.fromJson(e)).toList();
      categories = advices.map((e) => e.diseasesCategoryName).toSet().toList();
      emit(AdviceLoaded(advices));
    } catch (e) {
      emit(AdviceError(e.toString()));
    }
  }

  Future<void> likeAdvice(String adviceId) async {
    try {
      await adviceRepo.createLike(adviceId);
      emit(AdviceLikeSuccess());
      getAdvices();
    } catch (e) {
      emit(AdviceError("Failed to like advice: \$e"));
      getAdvices();
    }
  }

  Future<void> dislikeAdvice(String adviceId) async {
    try {
      await adviceRepo.createDislike(adviceId);
      getAdvices();
      emit(AdviceDislikeSuccess());
    } catch (e) {
      emit(AdviceError("Failed to dislike advice: \$e"));
      getAdvices();
    }
  }

  Future<void> createAdvice({
    required String diseasesCategoryId,
    required String title,
    required String description,
  }) async {
    emit(AdviceCreating());
    try {
      //TODO: REmember to access category id from the selected category & doctor id
      await adviceRepo.createAdvice(
        diseasesCategoryId: '67bf1284a133949f719b01e2',
        title: title,
        description: description,
        doctorId: '6852a434bc451d9b3e2ecca8',
      );
      emit(AdviceCreated('Advice created successfully'));
      getAdvices();
    } catch (e) {
      emit(AdviceCreatingError("Failed to create advice, try again later"));
      getAdvices();
    }
  }
}
