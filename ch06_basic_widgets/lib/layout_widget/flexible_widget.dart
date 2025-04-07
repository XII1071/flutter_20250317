import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlexibleWidgetExample extends StatelessWidget {
  int rateFlex1 = 3, rateFlex2 = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Flexible(
                flex: rateFlex1,
                child: Container(
                  color: Colors.blue,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        '$rateFlex1',
                        style: TextStyle(
                          fontSize: 70.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: rateFlex2,
                child: Container(
                  color: Colors.red,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Text(
                        '$rateFlex2',
                        style: TextStyle(
                          fontSize: 70.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
