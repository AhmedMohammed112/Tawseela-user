import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/Home_Cubit/home_cubit.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/Home_Cubit/home_states.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/ride_request_button.dart';

import '../../../App/Constants/constants.dart';
import '../../Resources/color_manager.dart';
import '../../Resources/router_manager.dart';
import '../../Resources/values_manager.dart';
import '../line.dart';
import '../my_elevation_button.dart';
import '../my_text.dart';

class PickUpDetailsBox extends StatelessWidget {
  const PickUpDetailsBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BuildContext cont = context;
    return BlocBuilder<HomeCubit,HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.get(context);
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: cubit.directionDetailsInfo == null ? 200 : 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppSizes.s20),topRight: Radius.circular(AppSizes.s20)),
                // make a shadow for the box
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                // make a border for the box
                border: Border.all(
                  color: ColorManager.black,
                  width: 1,
                ),
              ),
              child: cubit.tStatus == "Waiting" ?
                  // waiting for driver to accept the ride
                  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: ColorManager.white,
                  ),
                  const SizedBox(height: 20,),
                  MyText(text: "Searching for driver", style: Theme.of(context).textTheme.displayLarge!,size: AppSizes.s20,),
                  // cancel button
                  const SizedBox(height: 20,),
                  MyElevationButton(
                    fun: () {
                      cubit.cancelRideByUser();
                    },
                    textButton: "Cancel",
                    widthButton: 120,
                    heightButton: 70,
                  ),
                ],
              ) :
                  // driver accepted the ride
                  Padding(
                padding: const EdgeInsets.all(AppPadding.p16),
                child: Column(
                  children: [
                    if(cubit.directionDetailsInfo != null)
                      cubit.driverId == 'Waiting' ?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(text: "Distance: ${cubit.directionDetailsInfo!.distanceText}", style: Theme.of(context).textTheme.displayLarge!,size: AppSizes.s20,),
                          const SizedBox(height: AppSizes.s8,),
                          MyText(text: "Duration: ${cubit.directionDetailsInfo!.durationText}", style: Theme.of(context).textTheme.displayLarge!,size: AppSizes.s20,),
                        ],
                      ) : MyText(text: cubit.tripStatus, style: Theme.of(context).textTheme.displayLarge!,size: AppSizes.s20,),
                    if(cubit.directionDetailsInfo != null)
                      const Line(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: MyText(
                              text: 'From:',
                              size: AppSizes.s15,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge! ,
                            ),
                          ),
                          const SizedBox(width: AppSizes.s10),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.searchScreen,
                                    arguments: PickTypes.up);
                              },
                              child: MyText(
                                text: cubit.pickUpAddress ??
                                    'Pick Up Location',
                                size: AppSizes.s15,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium! ,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Line(),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: MyText(
                              text: 'To:',
                              size: AppSizes.s15,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge! ,
                            ),
                          ),
                          const SizedBox(width: AppSizes.s10),
                          Expanded(
                            flex: 5,
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.searchScreen,
                                    arguments: PickTypes.off);
                              },
                              child: MyText(
                                text: cubit.dropOffAddress ??
                                    'Drop Off Location',
                                size: AppSizes.s15,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium! ,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSizes.s10),
                    if (cubit.dropOffLocation != null)
                      RideRequestButton(cont: context,)
                  ],
                ),
              )
              ,
            ),
          );
      },
    );
  }
}
