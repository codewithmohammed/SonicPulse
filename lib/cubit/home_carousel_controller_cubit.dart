import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBarCarouselController extends Cubit<CarouselController> {
  HomeAppBarCarouselController() : super(CarouselController());

  void animateAndChangePage(int pageNum) async {
    try {
      // Future.delayed(Duration(seconds: 3));
      // Assuming animateToPage might throw an exception
      await state.animateToPage(pageNum);
      emit(state);
    } catch (e) {
      // Handle the exception appropriately
      print('Error while changing page: $e');
    }
  }

   void jumpAndChangePage(int pageNum)  {
    try {
      // Future.delayed(Duration(seconds: 3));
      // Assuming animateToPage might throw an exception
       state.jumpToPage(pageNum);
      emit(state);
    } catch (e) {
      // Handle the exception appropriately
      print('Error while changing page: $e');
    }
  }
}

class HomeScreenCarouselController extends Cubit<CarouselController> {
  HomeScreenCarouselController() : super(CarouselController());

  void animateAndChangePage(int pageNum) async {
    try {
      // Future.delayed(Duration(seconds: 3));
      // Assuming animateToPage might throw an exception
      await state.animateToPage(pageNum,
          duration: Duration(milliseconds: 750), curve: Curves.linearToEaseOut);
      emit(state);
    } catch (e) {
      // Handle the exception appropriately
      print('Error while changing page: $e');
    }
  }
     void jumpAndChangePage(int pageNum)  {
    try {
      // Future.delayed(Duration(seconds: 3));
      // Assuming animateToPage might throw an exception
       state.jumpToPage(pageNum);
      emit(state);
    } catch (e) {
      // Handle the exception appropriately
      print('Error while changing page: $e');
    }
  }
}
