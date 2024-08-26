import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/helpers.dart';
import '../../../utils/themes.dart';
import '../../blocs/kegiatan_detail/kegiatan_detail_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/img.dart';

/// KerjaBaktiDocumentationSreen
class KerjaBaktiDocumentationSreen extends StatelessWidget {
  final int id;

  const KerjaBaktiDocumentationSreen({
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
      child: _KerjaBaktiDocumentationScreen(
        key: key,
        id: id,
      ),
    );
  }
}

class _KerjaBaktiDocumentationScreen extends StatefulWidget {
  final int id;

  const _KerjaBaktiDocumentationScreen({
    super.key,
    required this.id,
  });

  @override
  State<_KerjaBaktiDocumentationScreen> createState() =>
      __KerjaBaktiDocumentationScreenState();
}

class __KerjaBaktiDocumentationScreenState
    extends State<_KerjaBaktiDocumentationScreen> {
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
    var kerjaBakti = data.data!.attributes.kerjaBakti!;
    List<FileMetadata> photos = [];

    for (var i = 0; i < kerjaBakti.attributes.photos!.length; i++) {
      var e = kerjaBakti.attributes.photos![i];

      if (e.attributes.mime.startsWith('image/')) {
        if (e.attributes.provider == 'local') {
          photos.add(FileMetadata.remote(source: baseUrl + e.attributes.url));
        } else {
          photos.add(FileMetadata.remote(source: e.attributes.url));
        }
      }
    }

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
            child: BaseTypography(
              text: formatedDateTime(DateTime.parse(
                kerjaBakti.attributes.createdAt,
              )),
              type: 'label',
            ),
          ),
          const SizedBox(height: 8.0),
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
          const SizedBox(height: 12.0),
          const Divider(indent: 24.0, endIndent: 24.0),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: kerjaBakti.attributes.description,
            ),
          ),
          const SizedBox(height: 24.0),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: 'Gallery',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 8.0),
          for (var p in photos)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: SizedBox(
                    child: Img(
                      metadata: p,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
              ],
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
                  text: 'Dokumentasi',
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
