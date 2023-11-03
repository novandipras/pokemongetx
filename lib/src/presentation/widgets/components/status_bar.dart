import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemongetx/src/utils/constants/app_colors.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    super.key,
    this.value = 0,
  });

  final int? value;

  @override
  Widget build(BuildContext context) {
    int maxValue = 300;
    int positivePercentage = (value! / maxValue * 100).round();
    int negativePercentage = (100 - positivePercentage);
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 20,
          decoration: BoxDecoration(
              color: AppColors.greyExtraLight,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                ),
              ]),
        ),
        Row(
          children: [
            Expanded(
              flex: positivePercentage,
              child: Container(
                width: double.infinity,
                height: 20,
                decoration: BoxDecoration(
                    color: AppColors.redDark,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(1, 1),
                      ),
                    ]),
              ),
            ),
            Expanded(
              flex: negativePercentage,
              child: const SizedBox(),
            )
          ],
        ),
        Container(
          width: double.infinity,
          height: 20,
          alignment: Alignment.center,
          child: Text('$value/$maxValue',
              style: GoogleFonts.poppins(
                fontSize: 10,
                color: Colors.black,
              )),
        )
      ],
    );
  }
}
