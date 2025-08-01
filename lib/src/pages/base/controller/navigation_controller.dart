
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const int home = 0;
  static const int cart = 1;
  static const int orders = 2;
  static const int profile = 3;
}

class NavigationController extends GetxController {

  late PageController _pageController;
  late RxInt _currentIndex;//var observable do get x

  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;

  @override
  void onInit(){
    super.onInit();

    initNavigation(
      pageController: PageController(initialPage: NavigationTabs.home), 
      currentIndex: NavigationTabs.home,
    );
  }


  void initNavigation({
    required PageController pageController,
    required int currentIndex,
  }){

    _pageController = pageController;
    _currentIndex = currentIndex.obs;//var observable tem que ter o .obs

  }


  void navigatePageView(int page){
    if(_currentIndex.value == page) return;

    _pageController.jumpToPage(page);
    _currentIndex.value = page;
  }



}