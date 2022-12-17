import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:thence/screens/home/controller/homeController.dart';

void main() {
  test("Call Get Data API",()async{
    bool isDone = false;
    try{
      RxList<dynamic> res = await HomeController().getData();
      isDone = res.isNotEmpty;

    }catch(e){
      isDone = false;
    }
    expect(isDone, true);
  });
}
