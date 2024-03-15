import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class UpdateUserFreeTripsCountUsecase extends BaseUseCase<void,void> {
  final Repository repository;

  UpdateUserFreeTripsCountUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.updateUserFreeTripsCount();
  }
}
