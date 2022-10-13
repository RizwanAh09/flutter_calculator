import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'home_page.dart';

class SplashScreen extends StatelessWidget {
  String image =
      "https://cdn2.iconfinder.com/data/icons/ios7-inspired-mac-icon-set/512/Calculator_512.png";

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:
        Container(
          height: 200,
          width: 200,
          child:Image.network(image),
        ),
         nextScreen: HomePage(),
      splashTransition: SplashTransition.sizeTransition,
    );
  }
}
