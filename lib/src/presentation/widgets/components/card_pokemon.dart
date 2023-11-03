import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemongetx/src/domain/models/pokelist_response_model.dart';
import 'package:pokemongetx/src/presentation/binding/get_monster_detail_page_binding.dart';
import 'package:pokemongetx/src/presentation/controller/get_my_pokemon_screen_controller.dart';
import 'package:pokemongetx/src/presentation/views/page.dart';
import 'package:pokemongetx/src/utils/constants/app_colors.dart';
import 'package:pokemongetx/src/utils/extensions/extensions.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({
    super.key,
    required this.pokeData,
    this.isMyPokemonScreen = false,
    this.getMyPokemonScreenController,
  });

  final Result pokeData;
  final bool isMyPokemonScreen;
  final GetMyPokemonScreenController? getMyPokemonScreenController;

  @override
  Widget build(BuildContext context) {
    double borderRadius = 8;
    List<String> pokeNumber = '${pokeData.url}'.split('/');
    pokeNumber.removeLast();
    return GestureDetector(
      onTap: () {
        GetMonsterDetailPageBinding().dependencies();
        Get.toNamed(MonsterDetailPage.routeName,
            arguments: MonsterDetailPage(
              isMyPokemonScreen: isMyPokemonScreen,
              resultPokeData: pokeData,
            ));
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isMyPokemonScreen ? AppColors.redLight : AppColors.redDark,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: Column(children: [
              AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Image.network(
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokeNumber.last}.png',
                      fit: BoxFit.contain,
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
              Text(
                (pokeData.name ?? '').toTitleCase(),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ]),
          ),
          if (isMyPokemonScreen)
            Opacity(
              opacity: 0.7,
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    getMyPokemonScreenController?.releasePokemon(
                      pokeData,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.greyMedium,
                      shape: BoxShape.circle,
                    ),
                    child:
                        const Icon(Icons.delete, color: Colors.white, size: 20),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
