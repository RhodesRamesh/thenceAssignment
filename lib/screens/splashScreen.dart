import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:thence/routers/router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3),()=>Get.offNamed(GetPageRouters.homeScreenPage));
    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: Lottie.asset("assets/meditating-man.json"),
        ),
      ),
    );
  }
}
