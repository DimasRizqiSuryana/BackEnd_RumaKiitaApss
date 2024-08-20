import 'dart:io';

import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'img.dart';

/// PickPreviewImg
///
/// Pick and Preview Image
class PickPreviewImg extends StatelessWidget {
  final GestureTapCallback? onTap;
  final File? file;
  final double? height;
  final double? width;
  final double aspectRatio;
  final double? pickIconSize;
  final BorderRadiusGeometry? borderRadius;

  const PickPreviewImg({
    super.key,
    this.onTap,
    this.file,
    this.height,
    this.width,
    required this.aspectRatio,
    this.pickIconSize,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.black,
              child: file != null
                  ? Img.file(
                      file: file!,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.expand(),
            ),
            Center(
              child: Icon(
                Icons.camera_alt_outlined,
                size: pickIconSize,
                color: cWhite,
              ),
            ),
            Material(
              color: cTransparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
