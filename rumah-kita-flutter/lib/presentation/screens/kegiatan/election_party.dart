import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/media/media_model.dart';
import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../blocs/election_party/election_party_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/img.dart';

/// ElectionPartyScreen
class ElectionPartyScreen extends StatelessWidget {
  final int id;

  const ElectionPartyScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ElectionPartyCubit>(
          lazy: false,
          create: (context) => sl<ElectionPartyCubit>(),
        ),
      ],
      child: _ElectionPartyScreen(
        key: key,
        id: id,
      ),
    );
  }
}

class _ElectionPartyScreen extends StatefulWidget {
  final int id;

  const _ElectionPartyScreen({
    super.key,
    required this.id,
  });

  @override
  State<_ElectionPartyScreen> createState() => __ElectionPartyScreenState();
}

class __ElectionPartyScreenState extends State<_ElectionPartyScreen> {
  void _fetch() {
    BlocProvider.of<ElectionPartyCubit>(context).dataRequested(widget.id);
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

  Widget _failureWidget(ElectionPartyState state) {
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

  FileMetadata? _photo(MediaModel? media) {
    FileMetadata? metadata;

    if (media == null) return metadata;

    var url = baseUrl;

    if (media.attributes.provider == 'local') {
      url += media.attributes.url;
    } else {
      url = media.attributes.url;
    }

    return FileMetadata.remote(source: url);
  }

  Widget _successWidget(ElectionPartyState data) {
    FileMetadata? photoKetua = _photo(data.data!.attributes.photoKetua);
    FileMetadata? photoWakilKetua =
        _photo(data.data!.attributes.photoWakilKetua);

    return RefreshIndicator(
      onRefresh: () async {
        _fetch();
      },
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: 'No ${data.data!.attributes.noUrut}',
              type: 'h2',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 12.0),
          const Divider(indent: 24.0, endIndent: 24.0),
          const SizedBox(height: 12.0),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: 'Ketua',
              type: 'h3',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  height: 200.0,
                  width: 180.0,
                  child: photoKetua != null
                      ? Img(
                          metadata: photoKetua,
                          fit: BoxFit.contain,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: data.data!.attributes.ketua,
              type: 'h3',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12.0),
          const Divider(indent: 24.0, endIndent: 24.0),
          const SizedBox(height: 12.0),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: 'Wakil Ketua',
              type: 'h3',
              fontWeight: fBold,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  height: 200.0,
                  width: 180.0,
                  child: photoWakilKetua != null
                      ? Img(
                          metadata: photoWakilKetua,
                          fit: BoxFit.contain,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTypography(
              text: data.data!.attributes.wakilKetua,
              type: 'h3',
              textAlign: TextAlign.center,
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
                  text: 'Calon Personil',
                  type: 'h3',
                  fontWeight: fBold,
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<ElectionPartyCubit, ElectionPartyState>(
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
