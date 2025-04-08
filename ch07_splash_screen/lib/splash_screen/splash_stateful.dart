import 'dart:async';

import 'package:ch07_splash_screen/splash_screen/mylist.dart';
import 'package:flutter/material.dart';

class SplashScreenStateful extends StatelessWidget {
  const SplashScreenStateful({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Mylist()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Container(
        decoration: BoxDecoration(color: Colors.yellow),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', width: 200,),
                SizedBox(height: 30.0,),
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
                // LinearProgressIndicator()
              ],
            )
          ],
        ),
      ),
    );
  }
}