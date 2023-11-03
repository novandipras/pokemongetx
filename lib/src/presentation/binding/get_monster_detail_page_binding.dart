import 'package:get/get.dart';
import 'package:pokemongetx/src/data/repositories/data_repository_impl.dart';
import 'package:pokemongetx/src/domain/usecases/usecase.dart';
import 'package:pokemongetx/src/presentation/controller/get_monster_detail_page_controller.dart';

class GetMonsterDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UseCase(Get.find<DataRepositoryImpl>()));
    Get.put(GetMonsterDetailPageController(Get.find()), permanent: true);
  }
}
