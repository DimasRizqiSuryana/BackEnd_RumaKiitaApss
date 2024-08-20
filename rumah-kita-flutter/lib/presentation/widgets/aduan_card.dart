import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'base_typography.dart';

/// AduanCard
class AduanCard extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String title;
  final String location;
  final String dateOfIncident;
  final String status;

  const AduanCard({
    super.key,
    this.onTap,
    required this.title,
    required this.location,
    required this.dateOfIncident,
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
                      const TextSpan(text: 'Lokasi : '),
                      TextSpan(
                        text: location,
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
                      const TextSpan(text: 'Waktu Kejadian : '),
                      TextSpan(
                        text: dateOfIncident,
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
