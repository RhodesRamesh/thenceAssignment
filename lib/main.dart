import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thence/routers/router.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: GetPageRouters.splashScreenPage,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme()
      ),
      getPages: GetPageRouters.pages,
    );
  }
}
