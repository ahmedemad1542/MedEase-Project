import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/advices/cubit/advices_state.dart';
import 'package:medease1/features/advices/model/advices_model.dart';

import 'package:medease1/features/advices/repo/advices_repo.dart';

class AdviceCubit extends Cubit<AdviceState> {
  final AdviceRepo adviceRepo;

  AdviceCubit(this.adviceRepo) : super(AdviceInitial());

  Future<void> getAdvices() async {
    emit(AdviceLoading());
    try {
      final response = await adviceRepo.getAllAdvices();
      final List<dynamic> data = response?.data['data'] ?? [];
      final advices = data.map((e) => AdviceModel.fromJson(e)).toList();
      emit(AdviceLoaded(advices));
    } catch (e) {
      emit(AdviceError(e.toString()));
    }
  }

  Future<void> likeAdvice(String adviceId) async {
    try {
      await adviceRepo.createLike(adviceId);
      emit(AdviceLikeSuccess());
    } catch (e) {
      emit(AdviceError("Failed to like advice: \$e"));
    }
  }

  Future<void> dislikeAdvice(String adviceId) async {
    try {
      await adviceRepo.createDislike(adviceId);
      emit(AdviceDislikeSuccess());
    } catch (e) {
      emit(AdviceError("Failed to dislike advice: \$e"));
    }
  }
}
