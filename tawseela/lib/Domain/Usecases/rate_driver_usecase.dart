import 'package:dartz/dartz.dart';
import 'package:tawseela/Data/Network/failure.dart';
import '../Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class RateDriverUsecase extends BaseUseCase<RateDriverUseCaseInput,void> {
  final Repository repository;

  RateDriverUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.rateDriver(input);
  }
}

class RateDriverUseCaseInput
{
    final String driverId;
    final String rideRequestId;
    final double driverRate;
    final List<Map<String,dynamic>> reviews;

    RateDriverUseCaseInput({required this.driverId,required this.rideRequestId,required this.driverRate,required this.reviews});
}
