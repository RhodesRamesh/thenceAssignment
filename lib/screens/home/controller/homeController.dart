import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thence/entity/Data.dart';
import 'package:thence/entity/ResponseEntity.dart';

class HomeController extends GetxController{

  RxInt selectedCatIndex = 1.obs;
  RxInt selectedBottomNavIndex = 0.obs;
  List<Data> plants = <Data>[].obs;

  @visibleForTesting
  Future getData() async {
    plants.clear();
    final res = await Dio().get("https://www.jsonkeeper.com/b/6Z9C");
    if(res!=null){
      if(res.statusCode==200){
        ResponseEntity entity = ResponseEntity.fromMap(res.data);
        entity.data.forEach((element) {
          Data data = Data.fromMap(element);
          plants.add(data);
        });
      }
      return Future.value(plants);
    }else{
      return Future.error("No Data");
    }
  }

  changeCatIndex(int index) {
    selectedCatIndex.value = index;
  }

  updateBotomNavIndex(int v) {
    selectedBottomNavIndex.value = v;
  }

}