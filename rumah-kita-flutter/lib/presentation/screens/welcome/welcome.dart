import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/helpers.dart';
import '../../../utils/themes.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/img.dart';

/// WelcomeScreen
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _WelcomeScreen(key: key);
  }
}

class _WelcomeScreen extends StatefulWidget {
  const _WelcomeScreen({
    super.key,
  });

  @override
  State<_WelcomeScreen> createState() => __WelcomeScreenState();
}

class __WelcomeScreenState extends State<_WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDarkBlue,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 32.0,
                horizontal: 24.0,
              ),
              decoration: const BoxDecoration(
                color: cTeal,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Img.asset(name: Assets.image('welcome-img.png')),
                  const SizedBox(height: 24.0),
                  const BaseTypography(
                    text: 'RumahKita',
                    type: 'h1',
                    fontWeight: fBold,
                    color: cWhite,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64.0),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: BaseTypography(
                text:
                    'Gerbang partisipasi aktif dalam pelayanan publik dan kegiatan masyarakat. Mengajukan surat dan mendapatkan informasi kegiatan masyarakat secara online, memperkuat hubungan antara pemerintah dan warga.',
                color: cWhite,
              ),
            ),
            const SizedBox(height: 64.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: BaseElevatedButton(
                onPressed: () {
                  context.push('/login');
                },
                borderRadius: 28.0,
                label: 'Masuk',
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: BaseTypography.richText(
                color: cWhite,
                fontWeight: fLight,
                textAlign: TextAlign.center,
                children: [
                  const TextSpan(text: 'Belum memiliki akun? '),
                  TextSpan(
                    text: 'Daftar',
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.push('/register');
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64.0),
          ],
        ),
      ),
    );
  }
}
