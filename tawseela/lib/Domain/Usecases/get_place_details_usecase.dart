import 'package:dartz/dartz.dart';
import 'package:tawseela/Domain/Models/place_details_model.dart';

import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class GetPlaceDetailsUsecase extends BaseUseCase<String,PlaceDetails> {
  final Repository repository;

  GetPlaceDetailsUsecase({required this.repository});

  @override
  Future<Either<Failure,PlaceDetails>> execute(input) {
    return repository.getPlaceDetails(input);
  }
}