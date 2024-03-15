import 'package:flutter/Material.dart';
import 'package:tawseela/Domain/Models/user_model.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Widgets/back_arrow.dart';
import 'package:tawseela/Presentation/Widgets/my_text.dart';

import '../../Widgets/line.dart';

class FreeTripsScreen extends StatelessWidget {
  final UserModel user;
  const FreeTripsScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackArrow(),
        title: MyText(
          text: 'Free Trips',
          size: AppSizes.s20,
          style: Theme.of(context).textTheme.displayLarge!,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: MyText(
                    text: 'You have ${user.freeTrips} free trips left, keep inviting friends to get more free trips',
                    size: AppSizes.s20,
                    style: Theme.of(context).textTheme.displayLarge!,
                  ),
                ),
              ),
            ),
            const Line(),
            MyText(text: "your Discounts", size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!),
            const SizedBox(height: AppSizes.s20,),
            if(user.discounts.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index) => Card(
                  child: Container(
                    padding: const EdgeInsets.all(AppPadding.p20),
                    child: MyText(
                      text: "${user.discounts[index].toString()} % discount on your next trip",
                      size: AppSizes.s20,
                      style: Theme.of(context).textTheme.displayLarge!,
                    ),
                  ),
                ),
                separatorBuilder: (context,index) => const SizedBox(height: AppSizes.s20,),
                itemCount: user.discounts.length,
              ),
            if(user.discounts.isEmpty)
              Card(
                child: Container(
                  padding: const EdgeInsets.all(AppPadding.p20),
                  child: MyText(
                    text: 'You have no discounts',
                    size: AppSizes.s20,
                    style: Theme.of(context).textTheme.displayLarge!,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
