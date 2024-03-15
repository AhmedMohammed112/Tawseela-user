import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Domain/Models/promo_code.dart';
import 'package:tawseela/Domain/Usecases/get_promo_code_usecase.dart';
import 'package:tawseela/Domain/Usecases/get_promo_codes_usecase.dart';
import 'package:tawseela/Presentation/Resources/color_manager.dart';
import 'package:tawseela/Presentation/Screens/Promos_Screen/Promos_Cubit/promos_states.dart';

import '../../../../App/Dependncy_Injection/di.dart';

class PromosCubit extends Cubit<PromosStates> {
  PromosCubit() : super(PromosInitialState());

  GetPromoCodesUsecase getPromoCodesUsecase = sl<GetPromoCodesUsecase>();
  GetMyPromoCodeUsecase getMyPromoCodeUsecase = sl<GetMyPromoCodeUsecase>();


  static PromosCubit get(context) => BlocProvider.of(context);

  List<PromoCode>? promoCodes;

  String status = '';
  Color statusColor = ColorManager.green;


  Future<void> getAllPromoCodes() async {
    emit(PromosLoadingState());
    final result = await getPromoCodesUsecase.execute(null);
    result.fold((failure) {
      emit(PromosErrorState(failure: failure));
    }, (data) {
      promoCodes = data;
      emit(PromosSuccessState());
    });
  }

  void getMyPromoCode(String code) async {
    bool isFound = false;
    for (var element in promoCodes!) {
      if(element.code == code)
      {
            if(element.users!.contains(FirebaseAuth.instance.currentUser!.uid))
            {
              isFound = true;
              status = 'You have already used this promo code';
              statusColor = ColorManager.red;
              emit(PromosSuccessState());
            }
            else
            {
              isFound = true;
              getPromoCode(element);
            }
      }
    }
    if(!isFound)
    {
      status = 'This promo code is not valid';
      statusColor = ColorManager.red;
      emit(PromosSuccessState());
    }
  }

  getPromoCode(PromoCode promo) async {
    emit(PromosLoadingState());
    List<dynamic> users = promo.users!;
    users.add(FirebaseAuth.instance.currentUser!.uid);
    final result = await getMyPromoCodeUsecase.execute(GetPromoCodeUsecaseData(promoCode: promo.id!, freeTrips: promo.freeRides!, discount: promo.discount!, users: users));
    result.fold((failure) {
      emit(PromosErrorState(failure: failure));
    }, (data) {
      status = 'Promo code added successfully';
      emit(PromosSuccessState());
    });
  }


}