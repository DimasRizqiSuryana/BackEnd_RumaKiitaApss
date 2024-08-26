import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/helpers.dart';
import '../../../utils/themes.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/avatar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_dialog.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/img.dart';

/// ProfileScreen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _ProfileScreen(key: key);
  }
}

class _ProfileScreen extends StatefulWidget {
  const _ProfileScreen({
    super.key,
  });

  @override
  State<_ProfileScreen> createState() => __ProfileScreenState();
}

class __ProfileScreenState extends State<_ProfileScreen> {
  FileMetadata? _photo;

  @override
  void initState() {
    super.initState();

    final user = BlocProvider.of<AuthBloc>(context).state.user!;

    if (user.detail!.photo != null) {
      _photo = user.detail!.photo!.toFileMetadata();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          Container(
            color: cDarkBlue,
            padding: const EdgeInsets.symmetric(
              vertical: 64.0,
              horizontal: 24.0,
            ),
            child: Column(
              children: [
                Avatar(
                  avatar: _photo,
                  size: 96.0,
                ),
                const SizedBox(height: 24.0),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return BaseTypography(
                      text: state.user!.detail!.fullname,
                      type: 'h2',
                      color: cWhite,
                    );
                  },
                ),
                const SizedBox(height: 8.0),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return BaseTypography(
                      text:
                          'RT/RW: ${state.user!.detail!.rt}/${state.user!.detail!.rw}',
                      color: cWhite,
                      fontWeight: fLight,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: 32.0,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: cDarkBlue,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(
                          64.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseElevatedButton(
              onPressed: () {
                context.push('/edit-profile');
              },
              backgroundColor: cLightYellow,
              child: Row(
                children: [
                  Img.asset(
                    name: Assets.image('person.png'),
                  ),
                  const SizedBox(width: 24.0),
                  const Expanded(
                    child: BaseTypography(
                      text: 'Edit Profil',
                      type: 'h3',
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseElevatedButton(
              onPressed: () async {
                final res = await showActionStrictConfirmDialog(
                  context: context,
                  confirmLabel: 'Logout',
                  children: [
                    const Center(
                      child: BaseTypography(
                        text: 'Logout',
                        type: 'h3',
                        textAlign: TextAlign.center,
                        fontWeight: fBold,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const Center(
                      child: BaseTypography(
                        text: 'Anda yakin ingin logout?',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );

                if (res && context.mounted) {
                  BlocProvider.of<AuthBloc>(context).add(AuthLogoutRequested());
                }
              },
              backgroundColor: cLightRed,
              child: Row(
                children: [
                  Img.asset(
                    name: Assets.image('logout.png'),
                  ),
                  const SizedBox(width: 24.0),
                  const Expanded(
                    child: BaseTypography(
                      text: 'Keluar',
                      type: 'h3',
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 64.0),
        ],
      ),
    );
  }
}
