import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Widgets/show_modal_button_sheet.dart';

import '../../Resources/assets_manager.dart';
import '../../Resources/values_manager.dart';
import '../../Screens/Home_Screen/Home_Cubit/home_cubit.dart';
import '../../Screens/Home_Screen/Home_Cubit/home_states.dart';
import '../line.dart';
import '../my_elevation_button.dart';
import '../my_text.dart';
import 'available_rides_container.dart';

class RideRequestButton extends StatelessWidget {
  final BuildContext cont;
  const RideRequestButton({Key? key, required this.cont}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit,HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        var cubit = HomeCubit.get(context);
        return cubit.assignedDriver != null ? MyElevationButton(
          fun: () {
            acceptedDriverModalBottomSheet(cont, cubit.assignedDriver!);
          },
          textButton: "Driver info"

        ) : MyElevationButton(
            fun: () {
              showBottomSheet(
                  context: context,
                  backgroundColor: Theme.of(context).primaryColor,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(AppPadding.p20),
                      child: Container(
                        height: AppSizes.s500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //const Center(child: Icon(Icons.horizontal_rule_rounded,size: AppSizes.s60,)),
                            ListTile(
                              leading: const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                                size: 30,
                              ),
                              title: MyText(
                                text: cubit.pickUpAddress!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!,
                              ),
                            ),
                            SizedBox(height: AppSizes.s10,),
                            ListTile(
                              leading: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 30,
                              ),
                              title: MyText(
                                text: cubit.dropOffAddress!,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!,
                              ),
                            ),
                            const Line(),
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cubit.selectedVehicle = "Car";
                                      },
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Image.asset(ImagesManager.sideCar2),
                                      ),
                                    ),
                                    const SizedBox(height: AppSizes.s10,),
                                    MyText(
                                      text: "Car",
                                      style:
                                      Theme.of(context)
                                          .textTheme
                                          .labelMedium!,
                                    ),
                                    const SizedBox(height: AppSizes.s10,),
                                    MyText(
                                      text: "Fare: ${cubit.calculateFare(percent: 4)}\$",
                                      style:
                                      Theme.of(context)
                                          .textTheme
                                          .labelMedium!,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        cubit.selectedVehicle = "Motor Cycle";
                                      },
                                      child: Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Image.asset(ImagesManager.motorCycle),
                                      ),
                                    ),
                                    const SizedBox(height: AppSizes.s10,),
                                    MyText(
                                      text: "Motor Cycle",
                                      style:
                                      Theme.of(context)
                                          .textTheme
                                          .labelMedium!,
                                    ),
                                    const SizedBox(height: AppSizes.s10,),
                                    MyText(
                                      text: "Fare: ${cubit.calculateFare(percent: 2)}\$",
                                      style:
                                      Theme.of(context)
                                          .textTheme
                                          .labelMedium!,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.s20,),
                            MyElevationButton(fun: () {
                              cubit.saveRideRequestInfo(cont);
                              Navigator.pop(cont);
                            }, textButton: "See Available Rides"),
                          ],
                        ),
                      ),
                    );
                  }
              );
            },
            widthButton: AppSizes.s200,
            textButton: "Request a ride");
      },
    );
  }
}
