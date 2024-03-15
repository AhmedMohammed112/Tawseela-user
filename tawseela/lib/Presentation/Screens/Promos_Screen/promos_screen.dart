import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Resources/assets_manager.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Screens/Promos_Screen/Promos_Cubit/promos_cubit.dart';
import 'package:tawseela/Presentation/Screens/Promos_Screen/Promos_Cubit/promos_states.dart';
import 'package:tawseela/Presentation/Widgets/back_arrow.dart';
import 'package:tawseela/Presentation/Widgets/my_elevation_button.dart';
import 'package:tawseela/Presentation/Widgets/my_text.dart';

import '../../Widgets/line.dart';
import '../../Widgets/my_text_field.dart';

class PromosScreen extends StatelessWidget {
  const PromosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController promoCodeController = TextEditingController();
    return BlocConsumer<PromosCubit,PromosStates>(
      listener: (context,state) {
        if(state is PromosErrorState)
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: MyText(text: state.failure.message!,size: AppSizes.s20,)));
          }
      },
      builder: (context,state) {
        var cubit = PromosCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: const BackArrow(),
            title: MyText(
              text: 'Promos',
              size: AppSizes.s20,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10,vertical: AppPadding.p64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(ImagesManager.promoLogo,height: AppSizes.s200,width: double.infinity,),
                  const SizedBox(height: AppSizes.s20,),
                  MyText(text: "Do you have a promo code?",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
                  const SizedBox(height: AppSizes.s50,),
                  MyTextFormField(
                      height: AppSizes.s100,
                      controller: promoCodeController,
                      validator: (value) {
                        if (value.isEmpty) return "Enter your promo code";
                        return null;
                      },
                      hintText: "Enter your promo code",
                      prefixIcon: const Icon(Icons.local_offer)),
                  const SizedBox(height: AppSizes.s20,),
                  MyElevationButton(
                    fun: () {
                      cubit.getMyPromoCode(promoCodeController.text);
                    },
                    textButton: "Apply",
                    widthButton: AppSizes.s200,
                  ),
                  const SizedBox(height: AppSizes.s20,),
                  MyText(text: cubit.status,size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!.copyWith(color: cubit.statusColor),),
                  const SizedBox(height: AppSizes.s20,),
                  const Line(),
                  const SizedBox(height: AppSizes.s20,),
                  MyText(text: "Available Promo codes",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
                  const SizedBox(height: AppSizes.s20,),
                  if(cubit.promoCodes != null)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: cubit.promoCodes!.length,
                    itemBuilder: (context,index)=>Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          child: ListTile(
                            title: MyText(text: "${cubit.promoCodes![index].freeRides!} free ride",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
                            trailing: MyElevationButton(
                              fun: () {},
                              textButton: "Use now",
                              widthButton: AppSizes.s130,
                              heightButton: AppSizes.s40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
