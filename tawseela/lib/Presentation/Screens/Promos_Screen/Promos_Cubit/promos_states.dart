import '../../../../Data/Network/failure.dart';
import '../../../../Domain/Models/promo_code.dart';

abstract class PromosStates {}

class PromosInitialState extends PromosStates {}

class PromosLoadingState extends PromosStates {}

class PromosSuccessState extends PromosStates {}

class PromosErrorState extends PromosStates {
  final Failure failure;

  PromosErrorState({required this.failure});
}