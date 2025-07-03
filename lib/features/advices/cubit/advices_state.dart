import 'package:medease1/features/advices/model/advices_model.dart';

abstract class AdvicesState {}

class AdvicesInitial extends AdvicesState {}

class AdvicesLoaded extends AdvicesState {
  List<AdvicesModel> advicesmodel;

  AdvicesLoaded(this.advicesmodel);
}

class AdvicesError extends AdvicesState {
  String errorMessage;

  AdvicesError(this.errorMessage);
}

class AdvicesLoading extends AdvicesState {}
