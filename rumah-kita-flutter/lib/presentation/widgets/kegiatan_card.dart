import 'package:flutter/material.dart';
import 'package:rumah_kita/presentation/widgets/list_item.dart';
import 'package:rumah_kita/utils/helpers.dart';

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
              ListItem(label: 'Kategori', value: kategori),
              ListItem(label: 'Status', value: status),
              ListItem(
                label: 'Mulai',
                value: formatedDateTime(DateTime.parse(
                  startDate,
                )),
              ),
              ListItem(
                label: 'Selesai',
                value: formatedDateTime(DateTime.parse(
                  finishDate,
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
