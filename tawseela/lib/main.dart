import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:tawseela/App/Constants/constants.dart';
import 'package:tawseela/App/Shared_Preferences/shared.dart';

import 'package:tawseela/Presentation/Resources/theme_manager.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/Home_Cubit/home_cubit.dart';
import 'package:tawseela/Presentation/Screens/Profile_Screen/Profile_Cubit/parfile_cubit.dart';
import 'package:tawseela/Presentation/Screens/Promos_Screen/Promos_Cubit/promos_cubit.dart';
import 'package:tawseela/Presentation/Screens/User_Trips_History_Screen/User_Trips_History_Cubit/user_trios_history_cubit.dart';
import 'App/Shared/Bloc_Observer.dart';
import 'App/Dependncy_Injection/di.dart';
import 'package:tawseela/App/Settings_Cubit/theme_cubit.dart';
import 'package:tawseela/App/Settings_Cubit/theme_states.dart';
import 'Presentation/Resources/router_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  await SharedPref.init();
  Bloc.observer = MyBlocObserver();
  init();
  Location location = Location();
  await location.requestPermission();
  currentLocationData = await location.getLocation();
  bool? isDark = SharedPref.getData(key: 'IsDark');

  String ?tripData = SharedPref.getTripData();
  print("CURRENT TRIP DATA IS: $tripData");
  currentTripData = tripData;
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;

  const MyApp({super.key, this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) =>
          ThemeCubit()
            ..changeMode(fromShared: isDark)),
          BlocProvider(create: (context) => ProfileCubit()),
          BlocProvider(create: (context) =>
          HomeCubit()
            ..getMyCurrentLocation(context)..initializeGeoFireListener()..getUserData()),
          BlocProvider(create: (context) => UserTripsHistoryCubit()..getUserTripsHistory()),
          BlocProvider(create: (context) => PromosCubit()..getAllPromoCodes()),
        ],

        child: BlocConsumer<ThemeCubit,ThemeStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                title: 'Tawseela',
                debugShowCheckedModeBanner: false,
                theme: getLightThemeData(),
                darkTheme: getDarkThemeData(),
                themeMode: ThemeCubit
                    .get(context)
                    .isDark ? ThemeMode.dark : ThemeMode.light,
                initialRoute: AppRoutes.splashScreen,
                onGenerateRoute: RouterManager.generateRoute,
              );
            }
            )
    );
  }
}