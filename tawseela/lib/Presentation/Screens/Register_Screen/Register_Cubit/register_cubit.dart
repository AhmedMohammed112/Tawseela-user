import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tawseela/Domain/Usecases/register_usecase.dart';
import 'package:tawseela/Presentation/Screens/Register_Screen/Register_Cubit/register_states.dart';

import '../../../../App/Dependncy_Injection/di.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final RegisterUsecase _registerUsecase = sl<RegisterUsecase>();

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(RegisterLoadingState());
    (await _registerUsecase.execute(RegisterUseCaseInput(
      name: name,
      email: email,
      phone: phone,
      address: address,
      password: password,
      trips: 0,
    ))).fold((l) {
      emit(RegisterErrorState(l.message.toString()));
    }, (r) {
      emit(RegisterSuccessState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  bool passwordValidator(String value) {
    RegExp regExp = RegExp(r'^(?=.*?[a-z])(?=.*?\d).{8,}$');
    if (regExp.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }
}