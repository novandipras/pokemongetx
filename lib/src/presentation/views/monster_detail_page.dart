import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemongetx/src/domain/models/model.dart';
import 'package:pokemongetx/src/presentation/controller/get_monster_detail_page_controller.dart';
import 'package:pokemongetx/src/presentation/widgets/monster_detail_information/status.dart';
import 'package:pokemongetx/src/presentation/widgets/widget.dart';
import 'package:pokemongetx/src/utils/constants/app_colors.dart';
import 'package:pokemongetx/src/utils/constants/app_enum.dart';
import 'package:pokemongetx/src/utils/resources/loading_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class MonsterDetailPage extends GetView<GetMonsterDetailPageController> {
  const MonsterDetailPage({
    super.key,
    required this.resultPokeData,
    this.isMyPokemonScreen = false,
  });

  static String routeName = '/monsterDetailPage';
  final Result resultPokeData;
  final bool isMyPokemonScreen;

  @override
  Widget build(BuildContext context) {
    return GetX<GetMonsterDetailPageController>(
      dispose: (state) {
        Get.delete<GetMonsterDetailPageController>();
      },
      init: controller,
      initState: (_) {
        controller.initMonsterDetailInfo(
          resultPokeData.url!,
          isMyPokemonScreen,
        );
      },
      builder: (getMonsterDetailPageController) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: getMonsterDetailPageController.pageRequestState.value ==
                      RequestState.Loaded
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          HeaderImage(
                            imageUrl: getMonsterDetailPageController
                                    .dataMonster.value?.sprites?.frontDefault ??
                                '',
                            controller: controller,
                            resultPokeData: resultPokeData,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TittleMonster(
                            dataMonster: getMonsterDetailPageController
                                .dataMonster.value!,
                          ),
                          Moves(
                            dataMonster: getMonsterDetailPageController
                                .dataMonster.value!,
                          ),
                          Status(
                            dataMonster: getMonsterDetailPageController
                                .dataMonster.value!,
                          )
                        ],
                      ),
                    )
                  : const LoadingShimmer(),
              floatingActionButton: Visibility(
                visible: !isMyPokemonScreen &&
                    getMonsterDetailPageController.pageRequestState.value ==
                        RequestState.Loaded &&
                    getMonsterDetailPageController.catchEnable.value == true,
                child: FloatingActionButton.extended(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  backgroundColor: AppColors.redDark,
                  label: Text('Catch',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      )),
                  icon: const Icon(
                    Icons.catching_pokemon,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.catchPokemon(jsonEncode(Result(
                            url:
                                getMonsterDetailPageController.urlMonster.value,
                            name: getMonsterDetailPageController
                                .dataMonster.value?.name)
                        .toJson()));
                  },
                ),
              ),
            ),
            if (getMonsterDetailPageController.dataRequestState.value ==
                RequestState.Loading)
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                color: Colors.white.withOpacity(0.9),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.redDark,
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
