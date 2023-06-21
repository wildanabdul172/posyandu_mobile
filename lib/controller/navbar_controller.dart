import 'package:get/get.dart';

class NavbarController extends GetxController {
  var currentIndex = 2.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}
