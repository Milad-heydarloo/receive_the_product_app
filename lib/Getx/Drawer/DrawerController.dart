import 'package:get/get.dart';

class MyDrawerController extends GetxController {
  // RxInt to manage the selected index
  var selectedIndex = 0.obs;

  // Method to change the selected index
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
