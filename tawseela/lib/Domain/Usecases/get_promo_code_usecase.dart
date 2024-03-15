import 'package:dartz/dartz.dart';
import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class GetMyPromoCodeUsecase extends BaseUseCase<GetPromoCodeUsecaseData,void> {
  final Repository repository;

  GetMyPromoCodeUsecase({required this.repository});

  @override
  Future<Either<Failure,void>> execute(input) {
    return repository.getPromoCode(input);
  }
}

class GetPromoCodeUsecaseData
{
    final String promoCode;
    final int freeTrips;
    final int discount;
    final List<dynamic> users;


    GetPromoCodeUsecaseData({required this.promoCode,required this.freeTrips,required this.discount,required this.users});
}