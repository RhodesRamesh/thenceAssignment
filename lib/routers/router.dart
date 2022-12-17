import 'package:get/get.dart';
import 'package:thence/screens/home/homePage.dart';
import 'package:thence/screens/plant/plantPage.dart';
import 'package:thence/screens/splashScreen.dart';

class GetPageRouters{
  static String splashScreenPage = "/";
  static String homeScreenPage = "/home";
  static String plantScreenPage = "/plant";

  static List<GetPage> pages =[
    GetPage(name: splashScreenPage, page:()=> const SplashScreen()),
    GetPage(name: homeScreenPage, page:()=> const HomePage()),
    GetPage(name: plantScreenPage, page:()=> PlantPage())
  ];
}