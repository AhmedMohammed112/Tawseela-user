import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/Home_Cubit/home_cubit.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/Home_Cubit/home_states.dart';

import '../../Resources/values_manager.dart';

class OpenDrawer extends StatelessWidget {
  final Scaffold scaffold;
  const OpenDrawer({Key? key, required this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit,HomeStates>(
      builder: (BuildContext context, HomeStates state) {
        return Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: CircleAvatar(
            radius: AppSizes.s30,
            child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 30,
                ),
                onPressed: () =>
                    scaffold.drawer
          ),
        )
        );
      },
    );
  }
}
