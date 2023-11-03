import 'package:get/get.dart';
import 'package:pokemongetx/src/data/repositories/data_repository_impl.dart';
import 'package:pokemongetx/src/domain/usecases/usecase.dart';
import 'package:pokemongetx/src/presentation/controller/get_catch_pokemon_screen_controller.dart';
import 'package:pokemongetx/src/presentation/controller/get_home_page_controller.dart';
import 'package:pokemongetx/src/presentation/controller/get_my_pokemon_screen_controller.dart';

class GetMyPokemonScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UseCase(Get.find<DataRepositoryImpl>()));
    Get.put(GetMyPokemonScreenController(Get.find()), permanent: true);
  }
}
