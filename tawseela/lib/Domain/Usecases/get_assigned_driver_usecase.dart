import 'package:dartz/dartz.dart';
import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Models/active_nearby_drivers.dart';
import 'package:tawseela/Domain/Models/driver_model.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class GetActiveDriversUsecase extends BaseUseCase<List<ActiveNearbyDriver>,List<AssignedDriver>> {
  final Repository repository;

  GetActiveDriversUsecase({required this.repository});

  @override
  Future<Either<Failure,List<AssignedDriver>>> execute(input) {
    return repository.getActiveDriversData(input);
  }
}
