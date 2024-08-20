import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/themes.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_typography.dart';

/// PemilihanScreen
class PemilihanScreen extends StatelessWidget {
  final int id;

  const PemilihanScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return _PemilihanScreen(
      key: key,
      id: id,
    );
  }
}

class _PemilihanScreen extends StatefulWidget {
  final int id;

  const _PemilihanScreen({
    super.key,
    required this.id,
  });

  @override
  State<_PemilihanScreen> createState() => __PemilihanScreenState();
}

class __PemilihanScreenState extends State<_PemilihanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RumahKitaAppBar(
              left: [
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                )
              ],
              middle: const [
                BaseTypography(
                  text: 'Detail Kegiatan',
                  type: 'h3',
                  fontWeight: fBold,
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
