import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/me/me_model.dart';
import '../../../data/models/surat_pengajuan/surat_pengajuan_model.dart';
import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/surat_pengajuan/surat_pengajuan_cubit.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/surat_pengajuan_card.dart';

/// InboxPengajuanSuratSection
class InboxPengajuanSuratSection extends StatelessWidget {
  const InboxPengajuanSuratSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SuratPengajuanCubit>(
          lazy: false,
          create: (context) => sl<SuratPengajuanCubit>(),
        ),
      ],
      child: _InboxPengajuanSuratSection(key: key),
    );
  }
}

class _InboxPengajuanSuratSection extends StatefulWidget {
  const _InboxPengajuanSuratSection({
    super.key,
  });

  @override
  State<_InboxPengajuanSuratSection> createState() =>
      __InboxPengajuanSuratSectionState();
}

class __InboxPengajuanSuratSectionState
    extends State<_InboxPengajuanSuratSection> {
  late final MeModel _me;
  final ScrollController _scrollController = ScrollController();

  void _fetch() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<SuratPengajuanCubit>(context)
          .dataRequested(userId: _me.id);
    }
  }

  @override
  void initState() {
    super.initState();
    _me = BlocProvider.of<AuthBloc>(context).state.user!;

    BlocProvider.of<SuratPengajuanCubit>(context).dataRequested(userId: _me.id);
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
        BlocListener<SuratPengajuanCubit, SuratPengajuanState>(
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
            BlocProvider.of<SuratPengajuanCubit>(context)
                .dataRequested(refresh: true, userId: _me.id);
          },
          child: BlocBuilder<SuratPengajuanCubit, SuratPengajuanState>(
            builder: (context, state) {
              List<SuratPengajuanModel> data = [];

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
                  var suratPengajuan = data[idx];

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    child: SuratPengajuanCard(
                      onTap: () {
                        context.push(
                            '/surat-pengajuan-detail/${suratPengajuan.id}');
                      },
                      jenisSuratPengajuan: suratPengajuan
                          .attributes.jenisSuratPengajuan!.attributes.label,
                      status: suratPengajuan
                          .attributes.documentStatus!.attributes.label,
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
