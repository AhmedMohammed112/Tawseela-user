import 'package:dartz/dartz.dart';
import 'package:tawseela/Domain/Models/user_model.dart';

import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class GetCurrentUserInfoUsecase extends BaseUseCase<String,UserModel> {
  final Repository repository;

  GetCurrentUserInfoUsecase({required this.repository});

  @override
  Future<Either<Failure,UserModel>> execute(input) async {
    return await repository.getCurrentUserData(input);
  }
}