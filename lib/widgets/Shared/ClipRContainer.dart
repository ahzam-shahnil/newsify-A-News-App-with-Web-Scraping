import 'package:flutter/material.dart';

class ClipRContainer extends StatelessWidget {
  const ClipRContainer({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.padding,
  }) : super(key: key);
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      padding: padding,
      height: height,
      width: width,
      child: child,
    );
  }
}
