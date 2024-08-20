import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'base_typography.dart';

/// SuratPengajuanCard
class SuratPengajuanCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String jenisSuratPengajuan;
  final String status;

  const SuratPengajuanCard({
    super.key,
    this.onTap,
    required this.jenisSuratPengajuan,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseTypography(
                text: jenisSuratPengajuan,
                type: 'h3',
                fontWeight: fBold,
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 32.0,
                runSpacing: 4.0,
                children: [
                  BaseTypography.richText(
                    color: Colors.black87,
                    children: [
                      const TextSpan(text: 'Status : '),
                      TextSpan(
                        text: status,
                        style: const TextStyle(
                          color: cTeal,
                          fontWeight: fBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
