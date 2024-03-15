import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/Material.dart';
import 'package:tawseela/App/Dependncy_Injection/di.dart';
import 'package:tawseela/Presentation/Screens/Login_Screen/login_screen.dart';
import '../Home_Screen/home_screen.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              initLogin();
              initGetUserInfo();
              return LoginScreen();
            }
            else
              {
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
                return const HomeScreen();
              }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
    );
  }
}
