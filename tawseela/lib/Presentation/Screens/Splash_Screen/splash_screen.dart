import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tawseela/Presentation/Widgets/my_text.dart';

import '../../Resources/router_manager.dart';
import '../../Resources/values_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 3), _goToNextScreen);
  }

  _goToNextScreen() {
    Navigator.pushNamed(context, AppRoutes.landingPage);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyText(
          text: 'Tawseela',
          size: AppSizes.s50,
          style: Theme.of(context).textTheme.displayLarge!,
        ),
      ),
    );
  }
}