import 'package:flutter/Material.dart';

import '../../Resources/color_manager.dart';
import '../../Resources/values_manager.dart';
import '../my_text.dart';

// cancelledTripDialog({required BuildContext context}) async
// {
//   return  showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: ColorManager.primary,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//           elevation: AppSizes.s20,
//           title: MyText(text: "Cancelled Trip",size: AppSizes.s20,),
//           content: MyText(text: "Your trip has been cancelled by the driver",size: AppSizes.s20,),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child:  MyText(text: "OK",size: AppSizes.s20,),
//             ),
//           ],
//         );
//       }
//   );
// }

void cancelledTripDialog({required BuildContext context}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 700),
    pageBuilder: (_, __, ___) {
      return Center(
          child: AlertDialog(
            backgroundColor: ColorManager.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: AppSizes.s20,
            title: MyText(text: "Cancelled Trip",size: AppSizes.s20,),
            content: MyText(text: "Your trip has been cancelled by the driver",size: AppSizes.s20,),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child:  MyText(text: "OK",size: AppSizes.s20,),
              ),
            ],
          )
      );
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      } else {
        tween = Tween(begin: Offset(1, 0), end: Offset.zero);
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