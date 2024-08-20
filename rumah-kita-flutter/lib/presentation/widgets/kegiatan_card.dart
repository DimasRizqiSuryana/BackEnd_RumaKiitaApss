import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'base_typography.dart';

/// KegiatanCard
class KegiatanCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String kategori;
  final String title;
  final String startDate;
  final String finishDate;
  final String status;

  const KegiatanCard({
    super.key,
    this.onTap,
    required this.kategori,
    required this.title,
    required this.startDate,
    required this.finishDate,
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
                text: title,
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
                      const TextSpan(text: 'Kategori : '),
                      TextSpan(
                        text: kategori,
                        style: const TextStyle(
                          color: cTeal,
                          fontWeight: fBold,
                        ),
                      ),
                    ],
                  ),
                  BaseTypography.richText(
                    color: Colors.black87,
                    children: [
                      const TextSpan(text: 'Mulai : '),
                      TextSpan(
                        text: startDate,
                        style: const TextStyle(
                          color: cTeal,
                          fontWeight: fBold,
                        ),
                      ),
                    ],
                  ),
                  BaseTypography.richText(
                    color: Colors.black87,
                    children: [
                      const TextSpan(text: 'Selesai : '),
                      TextSpan(
                        text: finishDate,
                        style: const TextStyle(
                          color: cTeal,
                          fontWeight: fBold,
                        ),
                      ),
                    ],
                  ),
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
