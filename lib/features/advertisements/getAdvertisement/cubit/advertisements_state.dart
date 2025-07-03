import 'package:medease1/features/advertisements/getAdvertisement/model/advertisements_model.dart';

abstract class AdvertisementsState {}

class AdvertisementsInitial extends AdvertisementsState {}

class AdvertisementsLoading extends AdvertisementsState {}

class Advertisementsloaded extends AdvertisementsState {
  final List<AdvertisementsModel> advertisements;
  final bool hasMore;
  final bool isLoadingMore;

  Advertisementsloaded(
    this.advertisements, {
    this.hasMore = true,
    this.isLoadingMore = false,
  });
}

class AdvertisementsError extends AdvertisementsState {
  final String message;

  AdvertisementsError(this.message);
}
