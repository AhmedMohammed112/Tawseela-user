import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Resources/color_manager.dart';
import 'package:tawseela/Presentation/Resources/router_manager.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Screens/Register_Screen/Register_Cubit/register_states.dart';
import 'package:tawseela/Presentation/Widgets/authentication_error_box.dart';
import 'package:tawseela/Presentation/Widgets/my_elevation_button.dart';

import '../../Resources/assets_manager.dart';
import '../../Widgets/my_text.dart';
import '../../Widgets/my_text_field.dart';
import 'Register_Cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final userNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pushNamed(context, AppRoutes.homeScreen);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(text: "Register", size: AppSizes.s40, style: Theme.of(context).textTheme.displayLarge!,),
                        const SizedBox(height: AppSizes.s10),
                        MyText(text: "Create an account to continue", size: AppSizes.s20, style: Theme.of(context).textTheme.headlineMedium!,),
                        const SizedBox(
                          height: AppSizes.s20
                        ),


                        if (state is RegisterErrorState)
                          AuthenticationErrorBox(message: state.error,),
                          const SizedBox(
                            height: AppSizes.s20
                          ),

                        // User Name
                        MyTextFormField(
                            controller: userNameController,
                            validator: (value) {
                              if (value.isEmpty) return "User Name Required";
                              return null;
                            },
                            labelText: "User Name",
                            prefixIcon: const Icon(Icons.person)),
                        const SizedBox(
                          height: AppSizes.s20
                        ),

                        // Email
                        MyTextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value.isEmpty) return "Email Required";
                              return null;
                            },
                            labelText: "Email Address",
                            prefixIcon: const Icon(Icons.email)),
                        const SizedBox(
                          height: AppSizes.s20
                        ),

                        // Phone and Address
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Phone
                            Expanded(
                              child: MyTextFormField(
                                controller: phoneController,
                                validator: (value) {
                                  if (value.isEmpty) return "Phone Required";
                                  return null;
                                },
                                labelText: "Phone Number",
                                prefixIcon: const Icon(Icons.phone),
                              ),
                            ),
                            const SizedBox(
                              width: AppSizes.s10),
                            // Address
                            Expanded(
                              child: MyTextFormField(
                                controller: addressController,
                                validator: (value) {
                                  if (value.isEmpty) return "Address Required";
                                  return null;
                                },
                                labelText: "Address",
                                prefixIcon: const Icon(Icons.location_on),
                              ),
                            ),
                          ]
                        ),
                        const SizedBox(
                          height: AppSizes.s20
                        ),

                        // Password
                        MyTextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password Required";
                            }
                            return null;
                          },
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.lock),
                          secureText: RegisterCubit.get(context).isPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            icon: Icon(RegisterCubit.get(context).suffix),
                          ),
                          //type: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: AppSizes.s20
                        ),

                        // Confirm Password
                        MyTextFormField(
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Password Confirmation Required";
                            } else if (confirmPasswordController.text !=
                                passwordController.text) {
                              return 'password does not match';
                            }
                            return null;
                          },
                          labelText: "Confirm Password",
                          prefixIcon: const Icon(Icons.lock),
                          secureText: RegisterCubit.get(context).isPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              RegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            icon: Icon(
                              RegisterCubit.get(context).suffix,
                            ),
                          ),
                          //type: TextInputType.visiblePassword,
                        ),
                        const SizedBox(
                          height: AppSizes.s40
                        ),

                        // Register Button
                        MyElevationButton(
                          fun: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                  name: userNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                  address: addressController.text,
                                  passwordConfirmation: confirmPasswordController.text);
                            }
                          },
                          textButton: "Register",
                          size: AppSizes.s20,
                          shadowColor: ColorManager.primary,
                          elevation: AppSizes.s30,
                          widthButton: double.infinity,
                        ),
                        const SizedBox(
                          height: AppSizes.s40
                        ),

                        // OR
                        Row(
                          children: [
                            Expanded(flex: AppSizes.s4.toInt(),child: const Divider(height: AppSizes.s20)),
                            Expanded(flex: AppSizes.s1.toInt(),child: Center(child: MyText(text: "OR",style: Theme.of(context).textTheme.displayLarge!,))),
                            Expanded(flex: AppSizes.s4.toInt(),child: const Divider(height: AppSizes.s20)),
                          ],
                        ),
                        const SizedBox(height: AppSizes.s20,),
                        // Google and Facebook
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(ImagesManager.googleLogo,height: AppSizes.s60,width: AppSizes.s60,),
                            const SizedBox(width: AppSizes.s40,),
                            Image.asset(ImagesManager.facebookLogo,height: AppSizes.s50,width: AppSizes.s50,),
                          ],
                        ),

                        // Already have an account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(text: "Already have an account?", size: AppSizes.s15, style: Theme.of(context).textTheme.labelMedium!,),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRoutes.loginScreen);
                              },
                              child: MyText(text: "Login", size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,)
                            ),
                          ],
                        ),
                ]
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
