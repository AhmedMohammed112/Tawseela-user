import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawseela/Domain/Models/place_autocomplete_response_model.dart';

import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class GetPredictionsUsecase extends BaseUseCase<String,PlaceAutocomplete> {
  final Repository repository;

  GetPredictionsUsecase({required this.repository});

  @override
  Future<Either<Failure,PlaceAutocomplete>> execute(input) {
    return repository.getPredictions(input);
  }
}