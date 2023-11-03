import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongetx/src/domain/models/model.dart';
import 'package:pokemongetx/src/presentation/controller/get_my_pokemon_screen_controller.dart';
import 'package:pokemongetx/src/presentation/widgets/widget.dart';

class MyPokemonScreen extends GetView<GetMyPokemonScreenController> {
  const MyPokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<GetMyPokemonScreenController>(
      init: controller,
      initState: (_) {
        controller.onInit();
      },
      builder: (getMyPokemonScreenController) {
        List<Result> dataResult =
            (getMyPokemonScreenController.pokeBag.value?.map((e) {
                  return Result.fromJson(jsonDecode(e));
                }).toList() ??
                []);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
              addAutomaticKeepAlives: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 8 / 10,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: dataResult.length,
              itemBuilder: (BuildContext context, index) {
                return CardPokemon(
                  pokeData: dataResult[index],
                  isMyPokemonScreen: true,
                  getMyPokemonScreenController: controller,
                );
              }),
        );
      },
    );
  }
}
