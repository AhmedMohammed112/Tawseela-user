import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tawseela/App/Constants/constants.dart';
import 'package:tawseela/Presentation/Resources/values_manager.dart';
import 'package:tawseela/Presentation/Screens/Drawer_Screen/drawer_screen.dart';
import 'package:tawseela/Presentation/Widgets/Screens_Widgets/pickup_details.dart';
import '../../Widgets/my_text.dart';
import 'Home_Cubit/home_cubit.dart';
import 'Home_Cubit/home_states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is ErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: MyText(
                text: state.failure.message!,
                size: AppSizes.s20,
                style: Theme.of(context).textTheme.labelSmall!,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: MyText(
                    text: "ok",
                    size: AppSizes.s20,
                    style: Theme.of(context).textTheme.labelMedium!,
                  ),
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return SafeArea(
          child: Scaffold(
            drawer: const NavDrawer(),
            body: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: GoogleMap(
                    padding: const EdgeInsets.only(bottom: AppSizes.s200),
                    mapType: cubit.selectedMapType,
                    // make a map dark theme or light theme

                    initialCameraPosition: CameraPosition(
                      target: cubit.pickUpLocation ?? const LatLng(30.033333, 31.233334),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      cubit.controller = controller;
                    },
                    //myLocationEnabled: true,
                    // make a map dark
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    markers: cubit.markers,
                    circles: cubit.circles,
                    polylines: cubit.polyLines,
                    onTap: (LatLng latLng) async {
                      cubit.updatePickUpLocation(latLng);
                    },
                  ),
                ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Builder(builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(AppPadding.p8),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: AppSizes.s30,
                          child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                size: AppSizes.s30,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              }),
                        ),
                      );
                    })),
                  // make a button to change map type by inserting a menu to choose from
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: AppSizes.s30,
                        child: IconButton(
                            icon: Icon(
                              Icons.map,
                              size: AppSizes.s30,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              cubit.changeMapType();
                            }),
                      ),
                    ),
                  ),
                if(currentTripData != null)
                  Align(
                      alignment: Alignment.topRight,
                      child: Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: AppSizes.s30,
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  size: AppSizes.s30,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                onPressed: () {
                                  cubit.checkCurrentTrip(context);
                                }),
                          ),
                        );
                      })),
                  const PickUpDetailsBox()
              ],
            ),
          ),
        );
      },
    );
  }
}

