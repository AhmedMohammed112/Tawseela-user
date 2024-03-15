import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/App/Settings_Cubit/theme_cubit.dart';
import 'package:tawseela/App/Settings_Cubit/theme_states.dart';
import 'package:tawseela/Presentation/Resources/color_manager.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Widgets/back_arrow.dart';

import '../../Resources/router_manager.dart';
import '../../Widgets/my_text.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit,ThemeStates>(
      builder: (BuildContext context, ThemeStates state) {
        var themeCubit = BlocProvider.of<ThemeCubit>(context);
        return Scaffold(
            appBar: AppBar(
              leading: BackArrow(),
              title: MyText(
                text: 'Settings',
                size: AppSizes.s20,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Center(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(AppPadding.p20),
                            child: MyText(
                              text: 'Dark theme',
                              size: AppSizes.s20,
                              style: Theme.of(context).textTheme.displayLarge!,
                            ),
                          ),
                          const Spacer(),
                          //switch button to change the theme
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Switch(
                              value: themeCubit.isDark,
                              activeColor: ColorManager.white,
                              onChanged: (value){
                                themeCubit.changeMode();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, AppRoutes.forgotPasswordScreen);
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(AppPadding.p20),
                        width: double.infinity,
                        child: MyText(
                          text: 'Change password',
                          size: AppSizes.s20,
                          style: Theme.of(context).textTheme.displayLarge!,
                                              ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}
