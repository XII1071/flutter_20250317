import 'package:flutter/material.dart';

class SplashScreenStateless extends StatelessWidget {
  const SplashScreenStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }
}