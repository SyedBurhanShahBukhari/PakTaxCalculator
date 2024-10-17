import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Set a timer to navigate to the WelcomeScreen after 3 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/tax-splash.gif', width: 300), // Your logo here
            SizedBox(height: 50.0), // Try setting this to 0 to remove space
            // Text(
            //   // 'Pakistan Tax Calculator',
            //   style: TextStyle(
            //     fontSize: 38,
            //     fontFamily: 'Overpass',
            //     fontWeight: FontWeight.bold,
            //     color: Colors.green,
            //   ),
            //   textAlign: TextAlign.center,
            // ),
          ],
        ),
      ),
    );
  }
}
