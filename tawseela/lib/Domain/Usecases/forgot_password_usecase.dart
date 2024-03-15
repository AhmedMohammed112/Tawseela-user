import 'package:dartz/dartz.dart';

import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class ForgotPasswordUsecase extends BaseUseCase<String,String> {
  final Repository repository;

  ForgotPasswordUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) async {
    return await repository.resetPassword(input);
  }
}