import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongetx/src/data/datasources/local/local_storage.dart';
import 'package:pokemongetx/src/domain/models/model.dart';
import 'package:pokemongetx/src/domain/usecases/usecase.dart';
import 'package:pokemongetx/src/utils/constants/constants.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class GetCatchPokemonScreenController extends GetxController {
  GetCatchPokemonScreenController(this.useCase);

  final UseCase useCase;

  var requestState = Rx<RequestState>(RequestState.Empty);
  var loadingList = Rx<RequestState>(RequestState.Empty);
  var prevUrl = Rx<String?>(null);
  var nextUrl = Rx<String?>(null);

  var dataList = Rx<PokelistResponseModel?>(null);
  var autoScrollController = Rx<AutoScrollController?>(
    AutoScrollController(axis: Axis.vertical),
  );

  initPokemonList() async {
    requestState.value = RequestState.Loading;
    final results = await useCase.executePokeList(AppString.urlInitPokeList);
    requestState.value = RequestState.Loaded;
    loadingList.value = RequestState.Loaded;
    dataList.value = results;
    prevUrl.value = results.previous;
    nextUrl.value = results.next;
  }

  fetchNextPokemonList() async {
    if (nextUrl.value != null) {
      loadingList.value = RequestState.Loading;
      final results = await useCase.executePokeList(nextUrl.value ?? '');
      loadingList.value = RequestState.Loaded;
      dataList.value = results;
      prevUrl.value = results.previous;
      nextUrl.value = results.next;
      jumpToTop();
    }
  }

  fetchPreviousPokemonList() async {
    if (prevUrl.value != null) {
      loadingList.value = RequestState.Loading;
      final results = await useCase.executePokeList(prevUrl.value ?? '');
      loadingList.value = RequestState.Loaded;
      dataList.value = results;
      prevUrl.value = results.previous;
      nextUrl.value = results.next;
      jumpToTop();
    }
  }

  jumpToTop(){
    autoScrollController.value?.jumpTo(autoScrollController.value!.position.minScrollExtent);
  }

}
