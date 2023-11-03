import 'package:flutter/material.dart';
import 'package:pokemongetx/src/domain/models/pokelist_response_model.dart';
import 'package:pokemongetx/src/presentation/controller/get_monster_detail_page_controller.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({
    super.key,
    required this.imageUrl, required this.controller, required this.resultPokeData,
  });

  final String imageUrl;
  final GetMonsterDetailPageController controller;
  final Result resultPokeData;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left_rounded,
                size: 24,
              ),
              onPressed: () {
                controller.fetchPreviousPokemonList();
              },
            ),
            Expanded(
              child: Image.network(
                imageUrl,
                fit: BoxFit.fitHeight,
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 24,
              ),
              onPressed: () {
                controller.fetchNextPokemonList();
              },
            ),
          ],
        ),
      ),
    );
  }
}
