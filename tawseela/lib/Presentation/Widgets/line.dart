

import 'package:flutter/Material.dart';
import 'package:tawseela/Presentation/Resources/color_manager.dart';

import '../Resources/values_manager.dart';

class Line extends StatelessWidget {
  const Line({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: AppPadding.p16),
      child: Container(
        height: AppSizes.s1,
        decoration: const BoxDecoration(
          color: ColorManager.grey,
          borderRadius: BorderRadius.all(Radius.circular(AppSizes.s10)),
        ),
      ),
    );
  }
}
