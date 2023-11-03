import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongetx/src/domain/usecases/usecase.dart';

class GetHomePageController extends GetxController {
  GetHomePageController(this.useCase);

  final UseCase useCase;


  var val = Rx<int?>(0);

  var pageController = Rx<PageController?>(null);

  initDataPage() {
    pageController.value = PageController(
      initialPage: val.value!,
    );
  }

  onPageChange(int value) {
    if (val.value != value) {
      val.value = value;
      pageController.value?.animateToPage(
        val.value!,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }
}
