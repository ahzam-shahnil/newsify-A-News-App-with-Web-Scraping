import 'package:flutter/material.dart';

import '../Shared/BlurImage.dart';
import '../Shared/ClipRContainer.dart';

class TopImageBlur extends StatelessWidget {
  const TopImageBlur({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRContainer(
      height: height,
      width: width,
      child: BlurImage(),
    );
  }
}
