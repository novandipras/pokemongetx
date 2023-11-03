import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:pokemongetx/src/utils/constants/constants.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({Key? key, this.radius = 0}) : super(key: key);

  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.greyLight.withOpacity(0.5),
      highlightColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius!)),
          color: AppColors.greyLight.withOpacity(0.5),
        ),
      ),
    );
  }
}
