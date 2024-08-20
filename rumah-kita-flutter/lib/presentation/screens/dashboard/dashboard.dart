import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';
import '../../../utils/themes.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/boot/boot_cubit.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/img.dart';
import '../../widgets/profile_banner.dart';

class _Card extends StatelessWidget {
  final String image;
  final String label;
  final GestureTapCallback? onTap;

  const _Card({
    // ignore: unused_element
    super.key,
    required this.image,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Img.asset(
                name: Assets.image(image),
                height: 48.0,
              ),
              BaseTypography(
                text: label,
                type: 'label',
                textAlign: TextAlign.center,
                fontWeight: fBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  final FileMetadata? image;
  final String label;
  final GestureTapCallback? onTap;

  const _BannerCard({
    // ignore: unused_element
    super.key,
    required this.image,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Positioned.fill(
            child: image != null
                ? Img(
                    metadata: image!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: cDarkBlue,
                  ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              color: cTeal,
              alignment: Alignment.center,
              child: BaseTypography(
                text: label,
                type: 'h3',
                color: cWhite,
              ),
            ),
          ),
          Positioned.fill(
            child: Material(
              color: cTransparent,
              child: InkWell(
                splashColor: cBlack.withOpacity(.1),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// DashboardScreen
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _DashboardScreen(key: key);
  }
}

class _DashboardScreen extends StatefulWidget {
  const _DashboardScreen({
    super.key,
  });

  @override
  State<_DashboardScreen> createState() => __DashboardScreenState();
}

class __DashboardScreenState extends State<_DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 32.0,
            ),
            color: cDarkBlue,
            child: Column(
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return ProfileBanner(
                      fullname: state.user!.detail!.fullname,
                      onNotif: () {},
                    );
                  },
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
          Container(
            height: 180.0,
            color: cDarkBlue,
            child: Stack(
              children: [
                Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(64.0),
                          ),
                          color: cWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: PhysicalModel(
                    clipBehavior: Clip.hardEdge,
                    color: cTeal,
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(24.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _Card(
                              onTap: () {
                                context.push('/create-kegiatan');
                              },
                              image: 'doc-3.png',
                              label: 'Pengajuan Kegiatan',
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: _Card(
                              onTap: () {
                                context.push('/create-aduan');
                              },
                              image: 'doc-2.png',
                              label: 'Aduan',
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: _Card(
                              onTap: () {
                                context.push('/create-surat-pengajuan');
                              },
                              image: 'doc-4.png',
                              label: 'Surat Pengajuan',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          SizedBox(
            height: 240.0,
            child: BlocBuilder<BootCubit, BootState>(
              builder: (context, state) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24.0,
                  ),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: state.kategoriKegiatan.length,
                  itemBuilder: (context, idx) {
                    var e = state.kategoriKegiatan[idx];
                    FileMetadata? cover;
                    if (e.attributes.cover != null) {
                      var provider = e.attributes.cover!.attributes.provider;
                      var url = e.attributes.cover!.attributes.url;
                      if (provider == 'local') {
                        cover = FileMetadata.remote(source: baseUrl + url);
                      } else {
                        cover = FileMetadata.remote(source: url);
                      }
                    }

                    return Container(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                      ),
                      width: 360.0,
                      child: _BannerCard(
                        onTap: () {
                          context.push(
                              '/kegiatan/${e.attributes.kategori}?title=${e.attributes.label}&banner=${cover?.source}');
                        },
                        image: cover,
                        label: e.attributes.label,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 64.0),
        ],
      ),
    );
  }
}
