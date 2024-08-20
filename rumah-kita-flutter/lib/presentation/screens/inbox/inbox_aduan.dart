import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/aduan/aduan_model.dart';
import '../../../data/models/me/me_model.dart';
import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../blocs/aduan/aduan_cubit.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/aduan_card.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_typography.dart';

/// InboxAduanSection
class InboxAduanSection extends StatelessWidget {
  const InboxAduanSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AduanCubit>(
          lazy: false,
          create: (context) => sl<AduanCubit>(),
        ),
      ],
      child: _InboxAduanSection(key: key),
    );
  }
}

class _InboxAduanSection extends StatefulWidget {
  const _InboxAduanSection({
    super.key,
  });

  @override
  State<_InboxAduanSection> createState() => __InboxAduanSectionState();
}

class __InboxAduanSectionState extends State<_InboxAduanSection> {
  late final MeModel _me;
  final ScrollController _scrollController = ScrollController();

  void _fetch() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<AduanCubit>(context).dataRequested(userId: _me.id);
    }
  }

  @override
  void initState() {
    super.initState();
    _me = BlocProvider.of<AuthBloc>(context).state.user!;

    BlocProvider.of<AduanCubit>(context).dataRequested(userId: _me.id);
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
        BlocListener<AduanCubit, AduanState>(
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
            BlocProvider.of<AduanCubit>(context)
                .dataRequested(refresh: true, userId: _me.id);
          },
          child: BlocBuilder<AduanCubit, AduanState>(
            builder: (context, state) {
              List<AduanModel> data = [];

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
                  var aduan = data[idx];

                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 8.0,
                    ),
                    child: AduanCard(
                      onTap: () {
                        context.push('/aduan-detail/${aduan.id}');
                      },
                      title: aduan.attributes.title,
                      location: aduan.attributes.location,
                      dateOfIncident: aduan.attributes.dateOfIncident,
                      status: aduan.attributes.documentStatus!.attributes.label,
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
