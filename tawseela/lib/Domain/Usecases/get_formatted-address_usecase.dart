import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class GetFormattedAddressUsecase extends BaseUseCase<LatLng,String> {
  final Repository repository;

  GetFormattedAddressUsecase({required this.repository});

  @override
  Future<Either<Failure,String>> execute(input) async {
    return await repository.getFormattedAddress(input.latitude, input.longitude);
  }
}