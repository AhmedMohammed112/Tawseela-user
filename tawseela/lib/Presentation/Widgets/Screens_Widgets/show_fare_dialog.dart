import 'package:flutter/Material.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/rate_driver_dialog.dart';
import '../../Resources/values_manager.dart';
import '../my_text.dart';

void showFareDialog({required BuildContext context,required double fareAmount}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.s20)),
            elevation: AppSizes.s20,
            title: MyText(text: "Fare",size: AppSizes.s20, style: Theme.of(context).textTheme.displayLarge!,),
            content: MyText(text: "Fare Amount: $fareAmount",size: AppSizes.s20, style: Theme.of(context).textTheme.labelMedium!,),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  rateDriverDialog(context);
                },
                child:  MyText(text: "OK",size: AppSizes.s20,style: Theme.of(context).textTheme.displayLarge!,),
              ),
            ],
          )
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


