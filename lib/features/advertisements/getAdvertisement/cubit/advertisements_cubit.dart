import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medease1/features/advertisements/getAdvertisement/cubit/advertisements_state.dart';
import 'package:medease1/features/advertisements/getAdvertisement/model/advertisements_model.dart';
import 'package:medease1/features/advertisements/getAdvertisement/repo/advertisements_repo.dart';

class AdvertisementsCubit extends Cubit<AdvertisementsState> {
  final AdvertisementsRepo advertisementsRepo;

  AdvertisementsCubit(this.advertisementsRepo) : super(AdvertisementsInitial());
  int page = 1;
  bool hasMore = true;
  List<AdvertisementsModel> advertisements = [];

  int totalPages = 1;

  Future<void> getAdvertisements({bool isloadMore = false}) async {
    if (!hasMore && isloadMore) return;

    if (!isloadMore) {
      page = 1;
      advertisements.clear();
      hasMore = true;
      emit(AdvertisementsLoading());
    } else {
      emit(
        Advertisementsloaded(
          advertisements,
          hasMore: hasMore,
          isLoadingMore: true,
        ),
      );
    }

    try {
      if (page <= totalPages) {
        final response = await advertisementsRepo.getAdvertisements(page: page);
        final newAdvertisements =
            response['advertisements'] as List<AdvertisementsModel>;
        totalPages = response['totalPages'] as int;
        log("totalPages: $totalPages");
        if (newAdvertisements.isEmpty && page <= totalPages) {
          hasMore = false;
        } else {
          advertisements.addAll(newAdvertisements);
          page++;
        }
      }

      emit(
        Advertisementsloaded(
          advertisements,
          hasMore: hasMore,
          isLoadingMore: false,
        ),
      );
    } on Exception catch (e) {
      emit(AdvertisementsError(e.toString()));
    }
  }
}
