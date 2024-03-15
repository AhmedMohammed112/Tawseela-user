
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Widgets/my_elevation_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Domain/Models/driver_model.dart';
import '../../Resources/router_manager.dart';
import '../../Screens/Home_Screen/Home_Cubit/home_cubit.dart';
import '../../Screens/Home_Screen/Home_Cubit/home_states.dart';
import '../line.dart';
import '../my_text.dart';
import 'package:http/http.dart' as http;

void acceptedDriverModalBottomSheet(BuildContext context,AssignedDriver driver) {
  showModalBottomSheet(
      backgroundColor: Theme.of(context).primaryColor,
      context: context, builder: (context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: Container(
        height: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                MyText(text: "Your request has been accepted",style: Theme.of(context).textTheme.displayLarge!,size: AppSizes.s20,),
                const Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.driverProfile,arguments: driver);
                    },
                    child: Icon(Icons.check_circle,color: Colors.green,size: 30,)),
              ],
            ),
            const Line(),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(AppSizes.s20),
                    ),
                    child: Center(
                      child: Image.network(driver.image!),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(child: MyText(text: driver.name!,style: Theme.of(context).textTheme.displayLarge!,size: 20,)),
                          Expanded(child: IconButton(
                            onPressed: () async {
                              await FlutterPhoneDirectCaller.callNumber("011111111");
                            },
                            icon: const Icon(Icons.call),color: Colors.green,))
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        children: [
                          const Icon(Icons.star,color: Colors.amber,),
                          const SizedBox(width: 10,),
                          MyText(text: driver.rating.toString(),style: Theme.of(context).textTheme.displayLarge!,size: 20,),
                        ],
                      ),

                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10,),
            const Line(),
            const SizedBox(height: 10,),
            Center(child: MyText(text: "Car Details",style: Theme.of(context).textTheme.displayLarge!,size: 20,)),
            const SizedBox(height: 10,),
            MyText(text: "Car Model: ${driver.vehicle!.name} ${driver.vehicle!.model}",style: Theme.of(context).textTheme.displayLarge!,size: 20,),
            const SizedBox(height: 10,),
           // MyText(text: "Car Number: ${driverDetails['vehicle']['plate_number']}",style: Theme.of(context).textTheme.displayLarge!,size: 20,),
            const SizedBox(height: 10,),
            MyText(text: "Car Color: ${driver.vehicle!.color}",style: Theme.of(context).textTheme.displayLarge!,size: 20,),

            // cancell ride button
            const Spacer(),

            BlocBuilder<HomeCubit,HomeStates>(
              builder: (context,state) {
                var cubit = HomeCubit.get(context);
                return MyElevationButton(
                  textButton: "Cancel Ride",
                  fun: () {
                    cubit.cancelRideByUser();
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  });
}