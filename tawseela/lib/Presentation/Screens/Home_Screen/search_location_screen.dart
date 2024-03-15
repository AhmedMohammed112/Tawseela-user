import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/Home_Cubit/home_cubit.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/home_screen.dart';
import 'package:tawseela/Presentation/Widgets/location_list_tile_loading.dart';
import '../../../App/Constants/constants.dart';
import '../../Resources/color_manager.dart';
import '../../Resources/values_manager.dart';
import '../../Widgets/line.dart';
import '../../Widgets/Screens_Widgets/location_list_tile.dart';
import '../../Widgets/my_elevation_button.dart';
import '../../Widgets/my_text.dart';
import '../../Widgets/my_text_field.dart';
import 'Home_Cubit/home_states.dart';

class SelectOnMapScreen extends StatelessWidget {
  final PickTypes type;
  const SelectOnMapScreen({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController placeController = TextEditingController();
    return BlocConsumer<HomeCubit,HomeStates>(
        listener: (context,state) {},
        builder: (context,state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: MyText(text: "Select on map",size: AppSizes.s20, style: Theme.of(context).appBarTheme.titleTextStyle!,
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              children: [
                MyTextFormField(
                  controller: placeController,
                  myOnChanged: (value) {
                    cubit.placeAutocomplete(query: value);
                  },

                  hintText: "Search your location",
                  prefixIcon: const Icon(Icons.location_pin,),
                  suffixIcon: const Icon(Icons.search,
                  ),
                  validator: (String value) {  },
                ),
                if(type == PickTypes.up)
                  const SizedBox(height: AppSizes.s10,),
                type == PickTypes.up ? MyElevationButton(
                  widthButton: AppSizes.s300,
                  heightButton: AppSizes.s45,
                  size: 20,
                  fun: () {
                    cubit.getMyCurrentLocation(context);
                    Navigator.pop(context);
                  },
                  textButton: "Use Your Current Location",
                ) :
                const Line(),
                const SizedBox(height: AppSizes.s20,),
                state is GetPredictionsLoadingState ?
                Expanded(
                  child: ListView.separated(
                    itemCount: cubit.predictions.length,
                    itemBuilder: (context, index) {
                      return const LocationListTileLoading();
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: AppSizes.s10,),
                  ),
                ) :
                Expanded(
                  child: ListView.builder(
                    itemCount: cubit.predictions.length,
                    itemBuilder: (context, index) {
                      return LocationListTile(
                        location: cubit.predictions[index].description!,
                        descreption: cubit.predictions[index].structuredFormatting!.secondaryText ?? '',
                        onPress: () async {
                          await cubit.updateDropSearchLocation(placeID: cubit.predictions[index].placeId!,type: type);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
          },
    );
  }
}
