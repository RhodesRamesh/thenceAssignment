import 'package:get/get.dart';
import 'package:thence/screens/splashScreen.dart';

class GetPageRouters{
  static String splashScreenPage = "/";
  static String homeScreenPage = "/home";
  static String plantScreenPage = "/plant";

  static List<GetPage> pages =[
    GetPage(name: splashScreenPage, page:()=> const SplashScreen())
  ];
}