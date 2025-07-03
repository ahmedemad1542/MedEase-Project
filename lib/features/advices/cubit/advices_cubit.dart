import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/advices/cubit/advices_state.dart';

import 'package:medease1/features/advices/repo/advices_reop.dart';

class AdvicesCubit extends Cubit<AdvicesState> {
  final AdvicesRepo repo;
  AdvicesCubit(this.repo) : super(AdvicesInitial());

  void getAdvices() async {
    emit(AdvicesLoading());
    final getAdvices = await repo.getAdvices();

    getAdvices.fold(
      (error) => emit(AdvicesError(error)),
      (advicesList) => emit(AdvicesLoaded(advicesList)),
    );
  }
}
