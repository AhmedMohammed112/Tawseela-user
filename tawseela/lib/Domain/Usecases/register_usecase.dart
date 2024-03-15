import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tawseela/Data/Network/failure.dart';
import 'package:tawseela/Domain/Repository/repository.dart';
import 'package:tawseela/Domain/Usecases/base_usecase.dart';

class RegisterUsecase extends BaseUseCase<RegisterUseCaseInput,UserCredential> {
  final Repository repository;

  RegisterUsecase({required this.repository});

  @override
  Future<Either<Failure,UserCredential>> execute(input) {
    return repository.createUserWithEmailAndPassword(input);
  }
}

class RegisterUseCaseInput
{
    final String name;
    final String email;
    final String phone;
    final String address;
    final String password;
    String image;
    final int trips;
    final int freeTrips;
    final List<dynamic> discounts;

    RegisterUseCaseInput({required this.trips,required this.name,required this.email,required this.phone,required this.address,this.password = 'null',this.image = 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',this.freeTrips = 0,this.discounts = const []});

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = <String, dynamic>{};
      data['name'] = name;
      data['email'] = email;
      data['phone'] = phone;
      data['address'] = address;
      data['image'] = image;
      data['trips'] = trips;
      data['free_trips'] = freeTrips;
      data['discounts'] = discounts;
      return data;
    }
}