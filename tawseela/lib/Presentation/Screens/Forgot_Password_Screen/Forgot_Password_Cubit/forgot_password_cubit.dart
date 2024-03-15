import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Domain/Usecases/forgot_password_usecase.dart';
import 'package:tawseela/Presentation/Screens/Forgot_Password_Screen/Forgot_Password_Cubit/forgot_password_states.dart';

import '../../../../App/Dependncy_Injection/di.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  static ForgotPasswordCubit get(context) => BlocProvider.of(context);

  ForgotPasswordUsecase forgotPasswordUsecase = sl<ForgotPasswordUsecase>();

  String message = '';
  void forgotPassword({required String email}) async {
     (await forgotPasswordUsecase.execute(email)).fold((l) {
            message = l.message!;
     }, (r) => {
       message = r
     });
  }
}