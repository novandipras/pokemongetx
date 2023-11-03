import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemongetx/src/domain/models/model.dart';
import 'package:pokemongetx/src/presentation/widgets/widget.dart';
import 'package:pokemongetx/src/utils/constants/constants.dart';
import 'package:pokemongetx/src/utils/extensions/extensions.dart';

class Status extends StatelessWidget {
  const Status({
    super.key,
    required this.dataMonster,
  });

  final PokemonDetailInfoResponseModel dataMonster;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: dataMonster.stats!.map((e) {
          bool isFirst = e == dataMonster.stats!.first;
          return Container(
            margin: EdgeInsets.only(
              top: isFirst ? 4 : 8,
              bottom: isFirst ? 0 : 0,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 40,
                  child: Text((e.stat?.name ?? '').toTitleCase(),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.greyDark,
                      )),
                ),
                Expanded(
                  flex: 60,
                  child: StatusBar(
                    value: e.baseStat,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
