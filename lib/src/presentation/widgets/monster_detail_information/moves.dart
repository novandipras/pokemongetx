import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemongetx/src/domain/models/model.dart';
import 'package:pokemongetx/src/utils/constants/constants.dart';

class Moves extends StatelessWidget {
  const Moves({
    super.key,
    required this.dataMonster,
  });

  final PokemonDetailInfoResponseModel dataMonster;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Moves',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.greyDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: dataMonster.moves!.map((e) {
              bool isFirst = e == dataMonster.moves!.first;
              return Container(
                margin: EdgeInsets.only(
                  left: isFirst ? 16 : 0,
                  right: isFirst ? 8 : 8,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 16,
                ),
                decoration: const BoxDecoration(
                    color: AppColors.redDark,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.5,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ]),
                child: Text(e.move?.name ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    )),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
