import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'img.dart';

class Avatar extends StatelessWidget {
  final FileMetadata? avatar;
  final double? size;

  const Avatar({
    super.key,
    this.avatar,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: size,
      decoration: const BoxDecoration(
        color: cOrange,
        shape: BoxShape.circle,
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: avatar != null
            ? Img(
                metadata: avatar!,
                fit: BoxFit.cover,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
