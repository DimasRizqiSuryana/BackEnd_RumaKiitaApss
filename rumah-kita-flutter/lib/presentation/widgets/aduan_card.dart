import 'package:flutter/material.dart';

import '../../utils/helpers.dart';
import '../../utils/themes.dart';
import 'base_typography.dart';
import 'list_item.dart';

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
              ListItem(
                labelFlex: 5,
                valueFlex: 7,
                label: 'Lokasi',
                value: location,
              ),
              ListItem(
                labelFlex: 5,
                valueFlex: 7,
                label: 'Status',
                value: status,
              ),
              ListItem(
                labelFlex: 5,
                valueFlex: 7,
                label: 'Waktu Kejadian',
                value: formatedDateTime(DateTime.parse(
                  dateOfIncident,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
