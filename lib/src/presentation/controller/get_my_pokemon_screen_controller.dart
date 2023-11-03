import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemongetx/src/data/datasources/local/local_storage.dart';
import 'package:pokemongetx/src/domain/models/pokelist_response_model.dart';
import 'package:pokemongetx/src/domain/usecases/usecase.dart';

import 'package:pokemongetx/src/utils/constants/constants.dart';
import 'package:pokemongetx/src/utils/extensions/extensions.dart';

class GetMyPokemonScreenController extends GetxController {
  GetMyPokemonScreenController(this.useCase);

  final UseCase useCase;
  var pokeBag = Rx<List<String>?>([]);
  final store = Get.find<LocalStorageService>();

  List<String>? get savedMonster => store.savedMonster;

  @override
  void onInit() async {
    super.onInit();
    pokeBag.value = store.savedMonster;
  }

  releasePokemon(Result pokeData) async {
    bool? a = await askConfirmationToRelease(pokeData);
    if (a == true) {
      store.releaseMonsterToNature = [jsonEncode(pokeData.toJson())];
      onInit();
    }

  }


  Future<bool?> askConfirmationToRelease(Result pokeData) async {
    List<String> pokeNumber = '${pokeData.url}'.split('/');
    pokeNumber.removeLast();
    bool? result = await Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Image.network(
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokeNumber.last}.png',
                            fit: BoxFit.contain,
                          )),
                      const SizedBox(height: 15),
                      Text(
                        "Are you sure want to release ${pokeData.name.toString().toTitleCase()} ?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFFFFFFF),
                              minimumSize: const Size(0, 45),
                              backgroundColor: AppColors.redDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Get.back(result: true);
                            },
                            child: const Text(
                              'YES',
                            ),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: AppColors.redDark,
                              backgroundColor: const Color(0xFFFFFFFF),
                              minimumSize: const Size(0, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text(
                              'Cancel',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
