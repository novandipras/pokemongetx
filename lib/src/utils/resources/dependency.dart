import 'package:get/get.dart';
import 'package:pokemongetx/src/data/repositories/data_repository_impl.dart';


class DependencyCreator {
  static init() {
    Get.lazyPut(() => DataRepositoryImpl());
  }
}
