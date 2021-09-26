import 'package:flutter/material.dart';
import 'package:untitled/constants/asset_paths.dart';
import 'package:untitled/widgets/loading.dart';
import 'package:untitled/widgets/logo_text.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LogoText(logoText: "Shopper", textSize :45.0,  textColor: Colors.black),
          ),
          SizedBox(height: 10,),
          Loading()
        ],
      ),
    );
  }
}
