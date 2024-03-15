import 'package:dartz/dartz.dart';
import 'package:tawseela/Domain/Usecases/register_usecase.dart';

import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class UpdateCurrentUserDataUsecase extends BaseUseCase<RegisterUseCaseInput,String> {
  final Repository repository;

  UpdateCurrentUserDataUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) {
    return repository.updateCurrentUserData(input);
  }
}