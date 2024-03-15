import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawseela/Domain/Models/request_details-info.dart';

import '../../Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'base_usecase.dart';

class GetRideRequestsUsecase extends BaseUseCase<void,List<RequestDetailsInfo>> {
  final Repository repository;

  GetRideRequestsUsecase({required this.repository});

  @override
  Future<Either<Failure,List<RequestDetailsInfo>>> execute(input) {
    return repository.getRideRequestsInfo();
  }
}