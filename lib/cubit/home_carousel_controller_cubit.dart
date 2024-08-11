// import 'dart:async';

// ignore_for_file: empty_catches

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// HomeAppBarCarouselController using GetX
class HomeAppBarCarouselController extends GetxController {
  final CarouselController carouselController = CarouselController();

  void animateAndChangePage(int pageNum) async {
    try {
      await carouselController.animateToPage(pageNum);
      update(); // Notify listeners
    } catch (e) {
    }
  }

  void jumpAndChangePage(int pageNum) {
    try {
      carouselController.jumpToPage(pageNum);
      update(); // Notify listeners
    } catch (e) {
    }
  }
}

// HomeScreenPageController using GetX
class HomeScreenPageController extends GetxController {
  final PageController pageController = PageController();

  void animateAndChangePage(int pageNum) async {
    try {
      await pageController.animateToPage(
        pageNum,
        duration: const Duration(milliseconds: 750),
        curve: Curves.linearToEaseOut,
      );
      update(); // Notify listeners
    } catch (e) {
    }
  }

  void jumpAndChangePage(int pageNum) {
    try {
      pageController.jumpToPage(pageNum);
      update(); // Notify listeners
    } catch (e) {
    }
  }
}
