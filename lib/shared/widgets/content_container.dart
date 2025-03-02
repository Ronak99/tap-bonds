import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsets padding;
  final BoxShape? shape;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadow;
  const ContentContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.shape,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
    this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
        boxShadow: shadow,
        shape: shape ?? BoxShape.rectangle,
        borderRadius: shape == BoxShape.circle
            ? null
            : borderRadius ?? BorderRadius.circular(8),
        border: Border.all(
          width: 0.5,
          color: const Color(0xffe5e7eb),
        ),
        color: Colors.white,
      ),
      child: child,
    );
  }
}
