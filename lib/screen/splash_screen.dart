import 'dart:async';

import 'package:flaviourfleet/features/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';

import '../utils/constant.dart';
import '../utils/custom_storage.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  navigateScreen() async {
    String? accessToken = await readTokenAccess();
    if (accessToken != null && accessToken.isNotEmpty) {
      ApiToken.token = accessToken.toString();
    }
    if (accessToken != null) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false,
          );
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false,
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    navigateScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent, // Set background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add a logo or image
            Image.asset(
              'assets/images/logo.png',
              height: 150.0,
            ),
            SizedBox(height: 20.0),
            Text(
              "FlaviourFleet",
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white, // Set text color
                fontWeight: FontWeight.bold, // Make text bold
              ),
            ),
            SizedBox(height: 20.0),
            CircularProgressIndicator(
              // Add a loading indicator
              color: Colors.white, // Set loading indicator color
            ),
          ],
        ),
      ),
    );
  }
}
