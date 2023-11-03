import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemongetx/src/data/datasources/local/local_storage.dart';
import 'package:pokemongetx/src/domain/models/model.dart';
import 'package:pokemongetx/src/domain/usecases/usecase.dart';
import 'package:pokemongetx/src/utils/constants/constants.dart';
import 'package:pokemongetx/src/utils/extensions/app_string_extension.dart';

class GetMonsterDetailPageController extends GetxController {
  GetMonsterDetailPageController(this.useCase);

  final UseCase useCase;

  var dataRequestState = Rx<RequestState?>(null);
  var pageRequestState = Rx<RequestState>(RequestState.Empty);
  var isFromMyPokemonScreen = Rx<bool>(false);
  var catchEnable = Rx<bool?>(null);
  var dataMonster = Rx<PokemonDetailInfoResponseModel?>(null);
  var urlMonster = Rx<String?>(null);

  final store = Get.find<LocalStorageService>();

  List<String>? get savedMonster => store.savedMonster;

  checkEnableToCatch(String? newData) {
    List<Result>? storeList =
        store.savedMonster?.map((e) => Result.fromJson(jsonDecode(e))).toList();
    Result newDataMap = Result.fromJson(jsonDecode(newData!));
    bool? zx = storeList?.any((element) => element.name == newDataMap.name);
    bool result = zx ?? true;
    catchEnable.value = !result;
    update();
  }

  initMonsterDetailInfo(String url, bool value) async {
    urlMonster.value = url;
    isFromMyPokemonScreen.value = value;
    pageRequestState.value = RequestState.Loading;
    final results = await useCase.executeMonsterDetailInfo(url);
    dataMonster.value = results;
    pageRequestState.value = RequestState.Loaded;
    checkEnableToCatch(
        jsonEncode(Result(url: url, name: dataMonster.value!.name).toJson()));
  }

  fetchNextPokemonList() async {
    if (isFromMyPokemonScreen.value == false) {
      List<String> urlPokeNumber = urlMonster.value!.split('/');
      urlPokeNumber.removeLast();
      urlPokeNumber.last = (int.parse(urlPokeNumber.last) + 1).toString();
      dataRequestState.value = RequestState.Loading;
      urlMonster.value =
          'https://pokeapi.co/api/v2/pokemon/${urlPokeNumber.last}/';
      final results = await useCase.executeMonsterDetailInfo(urlMonster.value!);
      dataMonster.value = results;
      checkEnableToCatch(jsonEncode(
          Result(url: urlMonster.value!, name: dataMonster.value!.name)
              .toJson()));
      dataRequestState.value = RequestState.Loaded;
    } else {
      List<Result>? storeList = store.savedMonster
              ?.map(
                (e) => Result.fromJson(jsonDecode(e)),
              )
              .toList() ??
          [];
      if (storeList.last.url != urlMonster.value!) {
        int nowIndex =
            storeList.indexWhere((element) => element.url == urlMonster.value!);
        urlMonster.value = storeList[nowIndex + 1].url;
        dataRequestState.value = RequestState.Loading;
        final results =
            await useCase.executeMonsterDetailInfo(urlMonster.value!);
        dataMonster.value = results;
        checkEnableToCatch(
          jsonEncode(
              Result(url: urlMonster.value!, name: dataMonster.value!.name)
                  .toJson()),
        );
        dataRequestState.value = RequestState.Loaded;
      }
    }
  }

  fetchPreviousPokemonList() async {
    if (isFromMyPokemonScreen.value == false) {
      List<String> urlPokeNumber = urlMonster.value!.split('/');
      urlPokeNumber.removeLast();
      urlPokeNumber.last = (int.parse(urlPokeNumber.last) - 1).toString();
      dataRequestState.value = RequestState.Loading;
      urlMonster.value =
          'https://pokeapi.co/api/v2/pokemon/${urlPokeNumber.last}/';
      final results = await useCase.executeMonsterDetailInfo(urlMonster.value!);
      dataMonster.value = results;
      checkEnableToCatch(
        jsonEncode(Result(url: urlMonster.value!, name: dataMonster.value!.name)
            .toJson()),
      );
      dataRequestState.value = RequestState.Loaded;
    } else {
      List<Result>? storeList = store.savedMonster
              ?.map(
                (e) => Result.fromJson(jsonDecode(e)),
              )
              .toList() ??
          [];
      if (storeList.first.url != urlMonster.value!) {
        int nowIndex =
            storeList.indexWhere((element) => element.url == urlMonster.value!);
        urlMonster.value = storeList[nowIndex - 1].url;
        dataRequestState.value = RequestState.Loading;
        final results =
            await useCase.executeMonsterDetailInfo(urlMonster.value!);
        dataMonster.value = results;
        checkEnableToCatch(
          jsonEncode(
              Result(url: urlMonster.value!, name: dataMonster.value!.name)
                  .toJson()),
        );
        dataRequestState.value = RequestState.Loaded;
      }
    }
  }

  openAndCloseLoadingDialog(String? newData) async {
    int levelToCatch = 20;
    int rand = (Random().nextInt(100) - levelToCatch);
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(
          child: SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 10,
              color: AppColors.redDark,
            ),
          ),
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(Get.overlayContext!).pop();

    if (rand > 50) {
      store.savedMonster = [newData!];
      checkEnableToCatch(newData);
      update();
      Get.dialog(
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
                              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${dataMonster.value?.id}.png',
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(height: 15),
                        Text(
                          "You're succesfully catch ${dataMonster.value?.name.toString().toTitleCase() ?? 'this pokemon'}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
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
                                Get.back();
                              },
                              child: const Text(
                                'OK',
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
        barrierDismissible: false,
      );
    } else {
      Get.dialog(
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
                        const Icon(
                          Icons.close_rounded,
                          size: 62,
                          color: AppColors.redDark,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Failed to catch ${dataMonster.value?.name ?? 'this pokemon'}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
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
                                Get.back();
                              },
                              child: const Text(
                                'OK',
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
        barrierDismissible: false,
      );
    }
  }

  Future<bool> askConfirmationToCatch() async {
    bool result = await Get.dialog(
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
                      const Icon(
                        Icons.question_mark_rounded,
                        size: 62,
                        color: AppColors.redDark,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Are you sure want to catch ${dataMonster.value?.name.toString().toTitleCase() ?? 'this pokemon'}",
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
                              'NO',
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

    return result;
  }

  catchPokemon(String? newData) async {
    bool result = await askConfirmationToCatch();
    if (result == true) {
      openAndCloseLoadingDialog(newData);
    }
  }
}
