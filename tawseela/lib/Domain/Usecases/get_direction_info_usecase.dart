import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawseela/Domain/Models/direction_details_info.dart';

import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class GetDirectionDetailsInfoUsecase extends BaseUseCase<DirectionDetailsInfoUsecaseParams,DirectionDetailsInfo> {
  final Repository repository;

  GetDirectionDetailsInfoUsecase({required this.repository});

  @override
  Future<Either<Failure,DirectionDetailsInfo>> execute(input) {
    return repository.getDirectionDetails(input);
  }
}

class DirectionDetailsInfoUsecaseParams {
  final LatLng origin;
  final LatLng destination;

  DirectionDetailsInfoUsecaseParams({required this.origin, required this.destination});
}