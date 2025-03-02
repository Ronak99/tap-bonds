import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_bonds/shared/widgets/content_container.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: ContentContainer(
        shape: BoxShape.circle,
        height: 36,
        width: 36,
        child: Center(
          child: SvgPicture.asset('assets/ArrowLeft.svg'),
        ),
      ),
    );
  }
}
