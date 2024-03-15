import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Screens/Forgot_Password_Screen/Forgot_Password_Cubit/forgot_password_cubit.dart';
import 'package:tawseela/Presentation/Screens/Forgot_Password_Screen/Forgot_Password_Cubit/forgot_password_states.dart';
import 'package:tawseela/Presentation/Widgets/my_elevation_button.dart';
import 'package:tawseela/Presentation/Widgets/my_text_field.dart';

import '../../Widgets/my_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    GlobalKey formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit,ForgotPasswordStates>(
        listener: (context,state) {},
        builder: (context,state) {
          var cubit = ForgotPasswordCubit.get(context);
          return Scaffold(
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MyText(text: "Reset Password",size: AppSizes.s40,
                        style: Theme.of(context).textTheme.displayLarge!,
                      ),
                      const SizedBox(height: AppSizes.s60,),
                      MyTextFormField(controller: emailController, validator: (email) {
                        if(emailController.text.isEmpty) {
                          return 'Email Required';
                        }
                      },
                      labelText: "Email Address",
                        prefixIcon: const Icon(Icons.email),
                      ),
                      const SizedBox(height: AppSizes.s20,),
                      MyElevationButton(
                          widthButton: AppSizes.s250,
                          fun: () {
                          cubit.forgotPassword(email: emailController.text);
                      }, textButton: "Reset Password"),
                      const SizedBox(height: AppSizes.s20,),
                      MyText(text: cubit.message,size: AppSizes.s20,
                        style: Theme.of(context).textTheme.displayLarge!,
                      ),
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}