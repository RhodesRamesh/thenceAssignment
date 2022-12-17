import 'package:get/get.dart';

class PlantController extends GetxController{
  RxInt selectedSizeIndex = 0.obs;

  updateSizeIndex(int index) {
    selectedSizeIndex.value = index;
  }
}