import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'avatar.dart';
import 'base_typography.dart';
import 'img.dart';

/// ProfileBanner
class ProfileBanner extends StatelessWidget {
  final FileMetadata? avatar;
  final String fullname;
  final VoidCallback? onNotif;
  final EdgeInsetsGeometry? padding;

  const ProfileBanner({
    super.key,
    this.avatar,
    required this.fullname,
    this.onNotif,
    this.padding = const EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 24.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        children: [
          Avatar(
            avatar: avatar,
            size: 56.0,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseTypography(
                  text: fullname,
                  color: cWhite,
                  fontWeight: fBold,
                ),
                const BaseTypography(
                  text: 'Selamat datang kembali',
                  type: 'label',
                  color: cWhite,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          IconButton(
            onPressed: onNotif,
            icon: const Icon(
              Icons.notifications_none,
              color: cWhite,
            ),
          ),
        ],
      ),
    );
  }
}
