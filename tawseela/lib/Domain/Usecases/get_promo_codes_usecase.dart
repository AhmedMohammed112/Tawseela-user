import 'package:dartz/dartz.dart';
import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Models/promo_code.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class GetPromoCodesUsecase extends BaseUseCase<void,List<PromoCode>> {
  final Repository repository;

  GetPromoCodesUsecase({required this.repository});

  @override
  Future<Either<Failure,List<PromoCode>>> execute(input) {
    return repository.getPromoCodes();
  }
}
