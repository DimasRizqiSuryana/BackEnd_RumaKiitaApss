import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/document_status/document_status_model.dart';
import '../../../data/models/kategori_kegiatan/kategori_kegiatan_model.dart';
import '../../../data/models/kegiatan/kegiatan_model.dart';
import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../blocs/boot/boot_cubit.dart';
import '../../blocs/kegiatan/kegiatan_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/kegiatan_card.dart';

/// KegiatanScreen
class KegiatanScreen extends StatelessWidget {
  final String title;
  final String kategoriKegiatan;
  final String banner;

  const KegiatanScreen({
    super.key,
    required this.title,
    required this.kategoriKegiatan,
    required this.banner,
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
      child: _KegiatanScreen(
        key: key,
        title: title,
        kategoriKegiatan: kategoriKegiatan,
        banner: banner,
      ),
    );
  }
}

class _KegiatanScreen extends StatefulWidget {
  final String title;
  final String kategoriKegiatan;
  final String banner;

  const _KegiatanScreen({
    super.key,
    required this.title,
    required this.kategoriKegiatan,
    required this.banner,
  });

  @override
  State<_KegiatanScreen> createState() => __KegiatanScreenState();
}

class __KegiatanScreenState extends State<_KegiatanScreen> {
  late final DocumentStatusModel _documentStatus;
  late final KategoriKegiatanModel _kategoriKegiatan;
  final ScrollController _scrollController = ScrollController();

  void _fetch() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      BlocProvider.of<KegiatanCubit>(context).dataRequested(
        kategoriKegiatanId: _kategoriKegiatan.id,
        documentStatusId: _documentStatus.id,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final boot = BlocProvider.of<BootCubit>(context).state;

    for (var i = 0; i < boot.documentStatus.length; i++) {
      var e = boot.documentStatus[i];

      if (e.attributes.status == 'approved') {
        _documentStatus = e;
        break;
      }
    }

    for (var i = 0; i < boot.kategoriKegiatan.length; i++) {
      var e = boot.kategoriKegiatan[i];

      if (e.attributes.kategori == widget.kategoriKegiatan) {
        _kategoriKegiatan = e;
        break;
      }
    }

    BlocProvider.of<KegiatanCubit>(context).dataRequested(
      kategoriKegiatanId: _kategoriKegiatan.id,
      documentStatusId: _documentStatus.id,
    );
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
    return Scaffold(
      body: MultiBlocListener(
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
        child: SafeArea(
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
                middle: [
                  BaseTypography(
                    text: widget.title,
                    type: 'h3',
                    fontWeight: fBold,
                  ),
                ],
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    BlocProvider.of<KegiatanCubit>(context).dataRequested(
                      refresh: true,
                      kategoriKegiatanId: _kategoriKegiatan.id,
                      documentStatusId: _documentStatus.id,
                    );
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
                                // if (widget.kategoriKegiatan == 'kerja-bakti') {
                                //   context.push('/kegiatan/kerja-bakti/1');
                                // } else {
                                // }
                              },
                              kategori: kegiatan.attributes.kategoriKegiatan!
                                  .attributes.label,
                              title: kegiatan.attributes.title,
                              startDate: kegiatan.attributes.startDate,
                              finishDate: kegiatan.attributes.finishDate,
                              status: kegiatan
                                  .attributes.documentStatus!.attributes.label,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
