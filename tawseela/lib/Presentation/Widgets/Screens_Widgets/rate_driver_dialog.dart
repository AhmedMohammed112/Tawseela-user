import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/Home_Cubit/home_cubit.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/Home_Cubit/home_states.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:tawseela/Presentation/Widgets/my_text_field.dart';
import '../../Resources/values_manager.dart';
import '../my_text.dart';

void rateDriverDialog(BuildContext context) {
  TextEditingController commentReviewController = TextEditingController();
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return BlocBuilder<HomeCubit,HomeStates>(
        builder: (context,state) {
          var cubit = HomeCubit.get(context);
          return AlertDialog(
            title: MyText(text: "Rate Driver",size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // rate widget
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSizes.s20),
                  child: SmoothStarRating(
                    starCount: AppSizes.s5.toInt(),
                    spacing: AppSizes.s10,
                    rating: cubit.driverRate,
                    size: AppSizes.s30,
                    color: Colors.amber,
                    borderColor: Colors.amber,
                    onRatingChanged: (rate) {
                      cubit.changeRateStatus(rate,context);
                    },
                  ),
                ),
                const SizedBox(height: AppSizes.s20,),
              MyText(
              text: cubit.rateStatus,
              size: AppSizes.s20,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: cubit.rateStatusColor),
              ),
                const SizedBox(height: AppSizes.s20,),
                MyTextFormField(
                   controller: commentReviewController,
                   hintText: "Write your review",
                )
              ],
            ),
            actions: [
              TextButton(onPressed: () {
                cubit.submitDriverReview(review: commentReviewController.text);
                Navigator.pop(context);
              }, child: MyText(text: "OK",size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,),
              )
            ],
          );
        },
      );

    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(anim),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}