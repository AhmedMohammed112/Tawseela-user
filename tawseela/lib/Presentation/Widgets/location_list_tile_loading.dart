import 'package:flutter/Material.dart';

import '../Resources/color_manager.dart';
import '../Resources/values_manager.dart';

class LocationListTileLoading extends StatelessWidget {
  const LocationListTileLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s20),
      ),
      tileColor: ColorManager.grey,
    );
  }
}
