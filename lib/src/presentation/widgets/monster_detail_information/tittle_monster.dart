import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemongetx/src/domain/models/model.dart';
import 'package:pokemongetx/src/utils/extensions/extensions.dart';

import '../../../utils/constants/constants.dart';


class TittleMonster extends StatelessWidget {
  const TittleMonster({
    super.key,
    required this.dataMonster,
  });

  final PokemonDetailInfoResponseModel dataMonster;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          (dataMonster.name ?? '').toTitleCase(),
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: dataMonster.types!
                .map((e) => Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                  color: AppColors.redDark,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(1, 1),
                    ),
                  ]),
              child: Text(e.type?.name ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  )),
            ))
                .toList(),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    (dataMonster.weight.toString() ?? ''),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.greyDark,
                    ),
                  ),
                  Text(
                    'Weight',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.greyDark,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    (dataMonster.height.toString() ?? ''),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.greyDark,
                    ),
                  ),
                  Text(
                    'Height',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.greyDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          thickness: 2,
          color: AppColors.greyExtraLight,
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
