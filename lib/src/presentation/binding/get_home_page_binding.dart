import 'package:get/get.dart';
import 'package:pokemongetx/src/data/repositories/data_repository_impl.dart';
import 'package:pokemongetx/src/domain/usecases/usecase.dart';
import 'package:pokemongetx/src/presentation/controller/get_home_page_controller.dart';

class GetHomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UseCase(Get.find<DataRepositoryImpl>()));
    Get.put(GetHomePageController(Get.find()), permanent: true);
  }
}
