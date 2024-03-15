import 'package:dartz/dartz.dart';

import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class LogoutUsecase extends BaseUseCase<void,void> {
  final Repository repository;

  LogoutUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.logout();
  }
}