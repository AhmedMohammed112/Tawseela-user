import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Resources/color_manager.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Screens/Profile_Screen/Profile_Cubit/parfile_cubit.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/no_internet_box.dart';
import 'package:tawseela/Presentation/Widgets/back_arrow.dart';
import 'package:tawseela/Presentation/Widgets/my_elevation_button.dart';
import 'package:tawseela/Presentation/Widgets/my_text.dart';
import 'package:tawseela/Presentation/Widgets/my_text_field.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/profile_load.dart';

import '../../../Domain/Usecases/register_usecase.dart';
import '../../Widgets/line.dart';
import 'Profile_Cubit/profile_stetes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController tripsController = TextEditingController();

    return BlocConsumer<ProfileCubit,ProfileStates>(
        listener: (context,state) {},
        builder: (context,state) {
          var cubit = ProfileCubit.get(context);
          if(cubit.myData != null)
            {
              userNameController.text = cubit.myData!.name;
              emailController.text = cubit.myData!.email;
              phoneController.text = cubit.myData!.phone;
              addressController.text = cubit.myData!.address;
              tripsController.text = cubit.myData!.trips.toString();
            }

            if(state is ProfileInitialState)
              {
                cubit.getUserData();
              }
          return Scaffold(
            appBar: AppBar(
              leading: const BackArrow(),
              title: MyText(text: "Profile",
                size: AppSizes.s20,),
            ),
            body: (state is ProfileGetDataSuccessState) ?
            RefreshIndicator(
              onRefresh: () async {
                cubit.getUserData();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p16),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: AppSizes.s80,
                            backgroundImage: cubit.userImage(),
                          ),
                          Positioned(
                            bottom: AppSizes.s8,
                            right: AppSizes.s4,
                            child: CircleAvatar(
                              backgroundColor: ColorManager.primary,
                              radius: AppSizes.s20,
                              child: IconButton(icon: const Icon(Icons.camera_alt,size: AppSizes.s20),color: ColorManager.white, onPressed: () {
                                cubit.getUserImage();
                              },),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.s20,),
                      const Line(),
                      const SizedBox(height: AppSizes.s20,),
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
                      MyTextFormField(
                        controller: phoneController,
                        validator: (value) {
                          if (value.isEmpty) return "Phone Required";
                          return null;
                        },
                        labelText: "Phone Number",
                        prefixIcon: const Icon(Icons.phone),
                      ),
                      const SizedBox(
                          height: AppSizes.s20
                      ),
                      MyTextFormField(
                        controller: addressController,
                        validator: (value) {
                          if (value.isEmpty) return "Address Required";
                          return null;
                        },
                        labelText: "Address",
                        prefixIcon: const Icon(Icons.location_on),
                      ),
                      const SizedBox(
                          height: AppSizes.s50
                      ),
                      MyElevationButton(
                        widthButton: AppSizes.s200,
                        fun: () {
                          RegisterUseCaseInput data = RegisterUseCaseInput(
                            name: userNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                            trips: int.parse(tripsController.text),
                          );
                          cubit.imageFile != null ? cubit.updateUserImage(data: data) : cubit.updateProfileInfo(data: data,);
                        },
                        textButton: "Update",
                      ),
                    ],
                  ),
                ),
              ),
            ) :
            (state is ProfileGetDataErrorState) ?
                NoInternetBox(message: state.failure.message!, fun: () {
                  cubit.getUserData();
                }) :
            const LoadData()

          );
        },

    );
  }
}
