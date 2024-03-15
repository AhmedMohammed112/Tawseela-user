import 'package:flutter/material.dart';
import 'package:tawseela/App/Dependncy_Injection/di.dart';
import 'package:tawseela/Domain/Models/driver_model.dart';
import 'package:tawseela/Domain/Models/user_model.dart';
import 'package:tawseela/Presentation/Resources/page_slide_transition.dart';
import 'package:tawseela/Presentation/Screens/Forgot_Password_Screen/forgot_password_screen.dart';
import 'package:tawseela/Presentation/Screens/Help_Screen/help_screen.dart';
import 'package:tawseela/Presentation/Screens/Home_Screen/search_location_screen.dart';
import 'package:tawseela/Presentation/Screens/Login_Screen/login_screen.dart';
import 'package:tawseela/Presentation/Screens/Profile_Screen/profile_screen.dart';
import 'package:tawseela/Presentation/Screens/Promos_Screen/promos_screen.dart';
import 'package:tawseela/Presentation/Screens/Register_Screen/register_screen.dart';
import 'package:tawseela/Presentation/Screens/Landing_Screen/landing_page.dart';
import 'package:tawseela/Presentation/Screens/User_Trips_History_Screen/user_trips_history_screen.dart';

import '../../App/Constants/constants.dart';
import '../Screens/Driver_Profile_Screen/driver_profile.dart';
import '../Screens/Free_Trips_Screen/free_trips-screen.dart';
import '../Screens/Home_Screen/home_screen.dart';
import '../Screens/Settings_Screen/settings.dart';
import '../Screens/Splash_Screen/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String landingPage = '/landingPage';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';
  static const String forgotPasswordScreen = '/forgotPassword';
  static const String homeScreen = '/home';
  static const String searchScreen = '/searchScreen';
  static const String profileScreen = '/profileScreen';
  static const String myTripsScreen = '/myTripsScreen';
  static const String driverProfile = '/driverProfile';
  static const String freeTripsScreen = '/freeTripsScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String promoCodeScreen = '/promoCodeScreen';
  static const String helpScreen = '/helpScreen';
}

class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return PageSlideTransition(page: const SplashScreen());
      case AppRoutes.landingPage:
        return MaterialPageRoute(builder: (_) => const LandingPage());
      case AppRoutes.homeScreen:
        initGetUserInfo();
        initUpdateCurrentUserInfo();
        initGetFormattedAddress();
        initGetPredictions();
        initGetPlaceDetails();
        initGetDirectionDetailsInfo();
        initSaveRideRequestDetailsInfo();
        initGetRideRequestDetailsInfo();
        initGetAssignedDriverInfo();
        initRateDriver();
        initUpdateUserTripsCount();
        initUpdateUserFreeTripsCount();
        initCancelTrip();
        initSaveRideRequest();
        initListenToRideRequest();
        initLogout();
        return PageSlideTransition(page: const HomeScreen());
      case AppRoutes.searchScreen:
        final type = settings.arguments as PickTypes;
        return PageSlideTransition(page: SelectOnMapScreen(type: type));
      case AppRoutes.profileScreen:
        initGetUserInfo();
        initUpdateCurrentUserInfo();
        return PageSlideTransition(page: const ProfileScreen());
      case AppRoutes.loginScreen:
        initLogin();
        initGetUserInfo();
        return PageSlideTransition(page: LoginScreen());
      case AppRoutes.registerScreen:
        initRegister();
        return PageSlideTransition(page: RegisterScreen());
      case AppRoutes.forgotPasswordScreen:
        initForgetPassword();
        return PageSlideTransition(page: const ForgotPasswordScreen());
      case AppRoutes.myTripsScreen:
        return PageSlideTransition(page: const UserTripsHistoryScreen());
      case AppRoutes.driverProfile:
        final driver = settings.arguments as AssignedDriver;
        return PageSlideTransition(
            page: DriverProfileScreen(
          driver: driver,
        ));
      case AppRoutes.freeTripsScreen:
        final user = settings.arguments as UserModel;
        return PageSlideTransition(
            page: FreeTripsScreen(
          user: user,
        ));
      case AppRoutes.settingsScreen:
        return PageSlideTransition(page: const SettingsScreen());
      case AppRoutes.promoCodeScreen:
        initGetPromoCode();
        initGetMyPromoCode();
        return PageSlideTransition(page: const PromosScreen());
      case AppRoutes.helpScreen:
        return PageSlideTransition(page: const HelpScreen());
      default: // Error
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
