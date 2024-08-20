import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/kegiatan/kegiatan_model.dart';
import '../../../data/models/me/me_model.dart';
import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/kegiatan/kegiatan_cubit.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/kegiatan_card.dart';

/// InboxKegiatanSection
class InboxKegiatanSection extends StatelessWidget {
  const InboxKegiatanSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KegiatanCubit>(
          lazy: false,
          create: (context) => sl<KegiatanCubit>(),
        ),
      ],
      child: _InboxKegiatanSection(key: key),
    );
  }
}

class _InboxKegiatanSection extends StatefulWidget {
  const _InboxKegiatanSection({
    super.key,
  });

  @override
  State<_InboxKegiatanSection> createState() => __InboxKegiatanSectionState();
}

class __InboxKegiatanSectionState extends State<_InboxKegiatanSection> {
  late final MeModel _me;
  final ScrollController _scrollController = ScrollController();

  void _fetch() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<KegiatanCubit>(context).dataRequested(userId: _me.id);
    }
  }

  @override
  void initState() {
    super.initState();
    _me = BlocProvider.of<AuthBloc>(context).state.user!;

    BlocProvider.of<KegiatanCubit>(context).dataRequested(userId: _me.id);
    _scrollController.addListener(_fetch);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_fetch);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<KegiatanCubit, KegiatanState>(
          listenWhen: (_, current) {
            return current.status.isFailure;
          },
          listener: (context, state) {
            if (state.status.isFailure) {
              showSnackBar(
                context: context,
                content: BaseTypography(
                  text: state.error!.message,
                  fontWeight: fLight,
                ),
              );
            }
          },
        ),
      ],
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<KegiatanCubit>(context)
                .dataRequested(refresh: true, userId: _me.id);
          },
          child: BlocBuilder<KegiatanCubit, KegiatanState>(
            builder: (context, state) {
              List<KegiatanModel> data = [];

              if (state.status.isLoading) {
                data = state.data;
              } else if (state.status.isSuccess) {
                data = state.data;
              } else {
                return const SizedBox.shrink();
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, idx) {
                  var kegiatan = data[idx];

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    child: KegiatanCard(
                      onTap: () {
                        context.push('/kegiatan-detail/${kegiatan.id}');
                      },
                      kategori: kegiatan
                          .attributes.kategoriKegiatan!.attributes.label,
                      title: kegiatan.attributes.title,
                      startDate: kegiatan.attributes.startDate,
                      finishDate: kegiatan.attributes.finishDate,
                      status:
                          kegiatan.attributes.documentStatus!.attributes.label,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
