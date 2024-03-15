import 'package:flutter/material.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/drawer_image.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/drawer_list_tiles.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(AppSizes.s20),
          topRight: Radius.circular(AppSizes.s20),
        )
    ),
      elevation: AppSizes.s0,
      surfaceTintColor: Colors.red,
      clipBehavior: Clip.antiAliasWithSaveLayer,
        child: ListView(
          children:  const [
              DrawerImage(),
              DrawerListTiles(),
          ],
        ),
    );
  }
}
