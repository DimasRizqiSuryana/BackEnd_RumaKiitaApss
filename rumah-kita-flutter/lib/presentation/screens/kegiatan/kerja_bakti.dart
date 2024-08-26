import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';
import '../../../utils/themes.dart';
import '../../blocs/kegiatan_detail/kegiatan_detail_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/status_card.dart';

/// KerjaBaktiScreen
class KerjaBaktiScreen extends StatelessWidget {
  final int id;

  const KerjaBaktiScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KegiatanDetailCubit>(
          lazy: false,
          create: (context) => sl<KegiatanDetailCubit>(),
        ),
      ],
      child: _KerjaBaktiScreen(
        key: key,
        id: id,
      ),
    );
  }
}

class _KerjaBaktiScreen extends StatefulWidget {
  final int id;

  const _KerjaBaktiScreen({
    super.key,
    required this.id,
  });

  @override
  State<_KerjaBaktiScreen> createState() => __KerjaBaktiScreenState();
}

class __KerjaBaktiScreenState extends State<_KerjaBaktiScreen> {
  void _fetch() {
    BlocProvider.of<KegiatanDetailCubit>(context).dataRequested(widget.id);
  }

  @override
  void initState() {
    super.initState();

    _fetch();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _inProgressWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _failureWidget(KegiatanDetailState state) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseTypography(
                type: 'h3',
                text: state.error!.label,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              BaseElevatedButton(
                onPressed: () {
                  _fetch();
                },
                label: 'Refresh',
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _successWidget(KegiatanDetailState data) {
    var documentStatus = data.data!.attributes.documentStatus!;

    return RefreshIndicator(
      onRefresh: () async {
        _fetch();
      },
      child: ListView(
        children: [
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: StatusCard(
              status: documentStatus.attributes.status,
              label: documentStatus.attributes.label,
            ),
          ),
          const SizedBox(height: 12.0),
          const Divider(indent: 24.0, endIndent: 24.0),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: data.data!.attributes.title,
              type: 'h2',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: data.data!.attributes.description ?? '',
            ),
          ),
          const SizedBox(height: 24.0),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: 'Waktu Kegiatan',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BaseTypography(
                      text: 'Mulai',
                      color: cBlack,
                      fontWeight: fBold,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_alarm_rounded,
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: BaseTypography(
                            text: formatedDateTime(DateTime.parse(
                              data.data!.attributes.startDate,
                            )),
                            color: cTeal,
                            fontWeight: fBold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    const BaseTypography(
                      text: 'Selesai',
                      color: cBlack,
                      fontWeight: fBold,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_alarm_rounded,
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: BaseTypography(
                            text: formatedDateTime(DateTime.parse(
                              data.data!.attributes.finishDate,
                            )),
                            color: cTeal,
                            fontWeight: fBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BaseTypography(
                  text: 'Dokumen Kegiatan',
                  fontWeight: fBold,
                ),
                const SizedBox(height: 8.0),
                if (data.data!.attributes.attachment != null)
                  BaseElevatedButton(
                    onPressed: () async {
                      var src = baseUrl;
                      var url =
                          data.data!.attributes.attachment!.attributes.url;
                      var provider =
                          data.data!.attributes.attachment!.attributes.provider;
                      if (provider == 'local') {
                        src += url;
                      } else {
                        src = url;
                      }

                      await launchUrl(Uri.parse(src));
                    },
                    label: 'Buka Dokumen',
                    fontSize: fParagraph,
                    fontWeight: fMedium,
                    backgroundColor: cOrange,
                    foregroundColor: cBlack,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          const Divider(indent: 24.0, endIndent: 24.0),
          const SizedBox(height: 12.0),
          if (data.data!.attributes.kerjaBakti != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: BaseElevatedButton(
                onPressed: () {
                  context
                      .push('/kegiatan/kerja-bakti/documentation/${widget.id}');
                },
                borderRadius: 64.0,
                label: 'Lihat Dokumentasi',
                backgroundColor: cTeal,
                foregroundColor: cWhite,
              ),
            ),
          const SizedBox(height: 64.0),
        ],
      ),
    );
  }

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
                  text: 'Kerja Bakti',
                  type: 'h3',
                  fontWeight: fBold,
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<KegiatanDetailCubit, KegiatanDetailState>(
                  builder: (context, state) {
                if (state.status.isLoading) {
                  return _inProgressWidget();
                } else if (state.status.isFailure) {
                  return _failureWidget(state);
                } else if (state.status.isSuccess) {
                  return _successWidget(state);
                }

                return const SizedBox.shrink();
              }),
            ),
          ],
        ),
      ),
    );
  }
}
