import 'package:flutter/Material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tawseela/Domain/Models/driver_model.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Widgets/line.dart';
import 'package:tawseela/Presentation/Widgets/my_text.dart';

import '../../Widgets/back_arrow.dart';

class DriverProfileScreen extends StatelessWidget {
  final AssignedDriver? driver;
  const DriverProfileScreen({Key? key, this.driver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
        title: MyText(text: "Driver Profile",size: AppSizes.s20,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.s20),
        child: Column(
          children: [
            CircleAvatar(
              radius: AppSizes.s60,
              backgroundImage: NetworkImage(driver!.image!),
            ),
            const SizedBox(height: AppSizes.s10),
            MyText(text: driver!.name!,size: AppSizes.s20,style: Theme.of(context).textTheme.labelMedium!),
            const SizedBox(height: AppSizes.s10),
            const Line(),
            const SizedBox(height: AppSizes.s10),
            MyText(text: "Car details:",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
            const SizedBox(height: AppSizes.s10),
            Card(
              child: Container(
                padding: const EdgeInsets.all(AppSizes.s20),

                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(text: "Car model: ${driver!.vehicle!.name} ${driver!.vehicle!.model}",size: AppSizes.s20,style: Theme.of(context).textTheme.labelMedium!,),
                    MyText(text: "Car color: ${driver!.vehicle!.color}",size: AppSizes.s20,style: Theme.of(context).textTheme.labelMedium!,),
                    MyText(text: "Car number: ${driver!.vehicle!.plateNumber}",size: AppSizes.s20,style: Theme.of(context).textTheme.labelMedium!,),
                  ],
                ),
              ),
            ),
            const Line(),
            MyText(text: "Reviews:",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
            const SizedBox(height: AppSizes.s10,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: driver!.review.length,
                itemBuilder: (context,index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: AppSizes.s20,
                        backgroundImage: NetworkImage(driver!.review[index].image),
                      ),
                      title: MyText(text: driver!.review[index].name,size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
                      subtitle: MyText(text: driver!.review[index].comment,size: AppSizes.s15,style: Theme.of(context).textTheme.labelMedium!,),
                      // add rate widget
                      trailing: SmoothStarRating(
                        starCount: AppSizes.s5.toInt(),
                        spacing: AppSizes.s20,
                        size: AppSizes.s20,
                        color: Colors.amber,
                        borderColor: Colors.amber,
                        rating: driver!.review[index].rate.toDouble(),
                      )
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
