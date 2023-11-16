import 'dart:async';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongetx/src/presentation/controller/get_catch_pokemon_screen_controller.dart';
import 'package:pokemongetx/src/presentation/widgets/widget.dart';
import 'package:pokemongetx/src/utils/constants/constants.dart';
import 'package:pokemongetx/src/utils/resources/app_debounce.dart';
import 'package:pokemongetx/src/utils/resources/loading_shimmer.dart';
import 'package:scroll_to_index/scroll_to_index.dart';


class CatchPokemonScreen extends GetView<GetCatchPokemonScreenController> {
  const CatchPokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appDebouncer = AppDebounce(milliseconds: 1000);

    return GetX<GetCatchPokemonScreenController>(
      init: controller,
      initState: (_) {
        controller.initPokemonList();
      },
      builder: (getCatchPokemonScreenController) {
        if (getCatchPokemonScreenController.requestState.value ==
            RequestState.Loaded) {
          return Stack(
            children: [
              NotificationListener(
                onNotification: (value) {
                  if (value is ScrollEndNotification) {
                    if (getCatchPokemonScreenController
                            .autoScrollController.value?.position.pixels ==
                        getCatchPokemonScreenController.autoScrollController
                            .value?.position.maxScrollExtent) {
                      appDebouncer.run(() => controller.fetchNextPokemonList());
                    }
                  }
                  return true;
                },
                child: CustomRefreshIndicator(
                  onRefresh: () async {
                    controller.fetchPreviousPokemonList();
                  },
                  builder: MaterialIndicatorDelegate(
                    builder: (context, controller) {
                      return const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.redDark,
                        size: 30,
                      );
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                        addAutomaticKeepAlives: true,
                        controller: getCatchPokemonScreenController
                            .autoScrollController.value!,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 8 / 10,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: (getCatchPokemonScreenController
                                    .dataList.value?.results ??
                                [])
                            .length,
                        itemBuilder: (BuildContext context, index) {
                          return AutoScrollTag(
                            key: ValueKey(getCatchPokemonScreenController
                                .dataList.value?.results?[index]),
                            index: index,
                            controller: getCatchPokemonScreenController
                                .autoScrollController.value!,
                            child: CardPokemon(
                              pokeData: getCatchPokemonScreenController
                                  .dataList.value!.results![index],
                              isMyPokemonScreen: false,
                            ),
                          );
                        }),
                  ),
                ),
              ),
              if (getCatchPokemonScreenController.loadingList.value ==
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
        } else {
          return const LoadingShimmer();
        }
      },
    );
  }
}
