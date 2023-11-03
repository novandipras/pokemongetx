import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemongetx/src/presentation/binding/get_home_page_binding.dart';
import 'package:pokemongetx/src/presentation/views/page.dart';
import 'package:pokemongetx/src/utils/resources/dependency.dart';

import 'src/data/datasources/local/local_storage.dart';

Future<void> main() async {
  DependencyCreator.init();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

initServices() async {
  if (kDebugMode) {
    print('Starting services ...');
  }
  await Get.putAsync(() => LocalStorageService().init());

  if (kDebugMode) {
    print('All services started...');
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: "/",
      initialBinding: GetHomePageBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
        ),
        GetPage(
          name: MonsterDetailPage.routeName,
          page: () {
            MonsterDetailPage monsterDetailPage = Get.arguments;
            return monsterDetailPage;
          },
        ),
      ],
    );
  }
}
