import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/advices/cubit/advices_state.dart';
import 'package:medease1/features/advices/model/advices_model.dart';

import 'package:medease1/features/advices/repo/advices_reop.dart';

class AdviceCubit extends Cubit<AdviceState> {
  final AdviceRepo adviceRepo;

  AdviceCubit(this.adviceRepo) : super(AdviceInitial());

  List<AdviceModel> advices = [];

  Future<void> fetchAdvices() async {
    emit(AdviceLoading());
    try {
      final response = await adviceRepo.getAllAdvices();
      final List data = response?.data["data"] ?? [];
      advices = data.map((e) => AdviceModel.fromJson(e)).toList();
      emit(AdviceLoaded(advices));
    } catch (e) {
      emit(AdviceError(e.toString()));
    }
  }

  Future<void> createAdvice({
    required String diseasesCategoryId,
    required String title,
  }) async {
    emit(AdviceCreating());
    try {
      await adviceRepo.createAdvice(
        diseasesCategoryId: diseasesCategoryId,
        title: title,
      );
      emit(AdviceCreated());
      await fetchAdvices();
    } catch (e) {
      emit(AdviceCreatingError(e.toString()));
    }
  }

  Future<void> createDislike({
    required String diseasesCategoryId,
    required String title,
    required String description,
    required String doctorId,
  }) async {
    emit(AdviceCreating());
    try {
      await adviceRepo.createDislike(
        diseasesCategoryId: diseasesCategoryId,
        title: title,
        description: description,
        doctorId: doctorId,
      );
      emit(AdviceCreated());
      await fetchAdvices();
    } catch (e) {
      emit(AdviceCreatingError(e.toString()));
    }
  }

  Future<void> updateAdvice({
    required String adviceId,
    required String diseasesCategoryId,
    required String title,
    required String description,
  }) async {
    emit(AdviceCreating());
    try {
      await adviceRepo.updateAdvice(
        adviceId: adviceId,
        diseasesCategoryId: diseasesCategoryId,
        title: title,
        description: description,
      );
      emit(AdviceUpdated());
      await fetchAdvices();
    } catch (e) {
      emit(AdviceCreatingError(e.toString()));
    }
  }

  Future<void> deleteAdvice(String adviceId) async {
    emit(AdviceCreating());
    try {
      await adviceRepo.deleteAdvice(adviceId);
      emit(AdviceDeleted());
      await fetchAdvices();
    } catch (e) {
      emit(AdviceCreatingError(e.toString()));
    }
  }
}

