import 'package:dartz/dartz.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tawseela/Data/Response/request_details_info_response.dart';

import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class SaveRideRequestInfoUsecase extends BaseUseCase<RequestDetailsInfoResponse,String> {
  final Repository repository;

  SaveRideRequestInfoUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) {
    return repository.saveRideRequestInfo(input);
  }
}


class SaveRideRequestUsecase extends BaseUseCase<RequestDetailsInfoResponse,String> {
  final Repository repository;

  SaveRideRequestUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) {
    return repository.addRideRequest(input);
  }
}

class ListenToRideRequestUseCase extends BaseUseCase<String,DatabaseReference> {
  final Repository repository;

  ListenToRideRequestUseCase({required this.repository});

  @override
  Future<Either<Failure, DatabaseReference>> execute(input) async {
    return await repository.listenToRideRequest(input);
  }
}


