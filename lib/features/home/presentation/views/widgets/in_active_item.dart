import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: SvgPicture.asset(
        image,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          Colors.grey.shade400,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
