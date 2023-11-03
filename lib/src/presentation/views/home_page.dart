import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongetx/src/domain/models/model.dart';
import 'package:pokemongetx/src/presentation/binding/get_catch_pokemon_screen_binding.dart';
import 'package:pokemongetx/src/presentation/binding/get_my_pokemon_screen_binding.dart';
import 'package:pokemongetx/src/presentation/controller/get_home_page_controller.dart';
import 'package:pokemongetx/src/presentation/widgets/widget.dart';
import 'package:pokemongetx/src/utils/constants/app_colors.dart';

class HomePage extends GetView<GetHomePageController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<HomePageListModel> page = [
      HomePageListModel(
        childWidget: const CatchPokemonScreen(),
        icon: const Icon(
          Icons.directions_run,
        ),
        label: 'Catch Pokemon',
      ),
      HomePageListModel(
        childWidget: const MyPokemonScreen(),
        icon: const Icon(
          Icons.catching_pokemon,
        ),
        label: 'My Pokemon',
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GetX<GetHomePageController>(
        init: controller,
        initState: (_) {
          controller.initDataPage();
          GetCatchPokemonScreenBinding().dependencies();
          GetMyPokemonScreenBinding().dependencies();
        },
        builder: (getHomePageController) {
          return Scaffold(
            body: PageView(
              controller: getHomePageController.pageController.value,
              onPageChanged: (i) {
                controller.onPageChange(i);
              },
              children: page.map((e) => e.childWidget).toList(),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: getHomePageController.val.value!,
              selectedItemColor: AppColors.redLight,
              items: page
                  .map((e) => BottomNavigationBarItem(
                        icon: e.icon,
                        label: e.label,
                      ))
                  .toList(),
              onTap: (i) {
                controller.onPageChange(i);
              },
            ),
          );
        },
      ),
    );
  }
}
