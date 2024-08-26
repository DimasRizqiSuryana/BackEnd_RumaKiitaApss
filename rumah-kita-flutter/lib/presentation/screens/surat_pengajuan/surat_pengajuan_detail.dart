import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../blocs/boot/boot_cubit.dart';
import '../../blocs/surat_pengajuan_detail/surat_pengajuan_detail_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_dropdown_menu.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/status_card.dart';

/// SuratPengajuanDetailScreen
class SuratPengajuanDetailScreen extends StatelessWidget {
  final int id;

  const SuratPengajuanDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SuratPengajuanDetailCubit>(
          lazy: false,
          create: (context) => sl<SuratPengajuanDetailCubit>(),
        ),
      ],
      child: _SuratPengajuanDetailScreen(
        key: key,
        id: id,
      ),
    );
  }
}

class _SuratPengajuanDetailScreen extends StatefulWidget {
  final int id;

  const _SuratPengajuanDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<_SuratPengajuanDetailScreen> createState() =>
      __SuratPengajuanDetailScreenState();
}

class __SuratPengajuanDetailScreenState
    extends State<_SuratPengajuanDetailScreen> {
  final TextEditingController _jenisSuratPengajuanController =
      TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  void _fetch() {
    BlocProvider.of<BootCubit>(context).scheduledQueue();
    BlocProvider.of<SuratPengajuanDetailCubit>(context)
        .dataRequested(widget.id);
  }

  @override
  void initState() {
    super.initState();

    _fetch();
  }

  @override
  void dispose() {
    _jenisSuratPengajuanController.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _alamatController.dispose();

    super.dispose();
  }

  Widget _inProgressWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _failureWidget(SuratPengajuanDetailState state) {
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
                  BlocProvider.of<BootCubit>(context).scheduledQueue();
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

  Widget _successWidget(SuratPengajuanDetailState data) {
    var documentStatus = data.data!.attributes.documentStatus!;

    _fullnameController.text = data.data!.attributes.fullname;
    _emailController.text = data.data!.attributes.email;
    _alamatController.text = data.data!.attributes.alamat;

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
            child: BlocBuilder<BootCubit, BootState>(
              builder: (context, state) {
                return BaseDropdownMenu<int>.outlined(
                  initialSelection:
                      data.data!.attributes.jenisSuratPengajuan!.id,
                  onSelected: (val) {},
                  enabled: false,
                  label: 'Jenis Surat Pengajuan',
                  hintText: 'Jenis Surat Pengajuan',
                  requestFocusOnTap: true,
                  dropdownMenuEntries: state.jenisSuratPengajuan.map((e) {
                    return DropdownMenuEntry(
                      value: e.id,
                      label: e.attributes.label,
                    );
                  }).toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTextField.outlined(
              controller: _fullnameController,
              onChanged: (val) {},
              enabled: false,
              label: 'Nama Lengkap',
              labelColor: cBlack,
              hintText: 'Nama Lengkap',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTextField.outlined(
              controller: _emailController,
              onChanged: (val) {},
              enabled: false,
              label: 'Email',
              labelColor: cBlack,
              hintText: 'Email',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseTextField.outlined(
              controller: _alamatController,
              onChanged: (val) {},
              enabled: false,
              label: 'Alamat',
              labelColor: cBlack,
              hintText: 'Alamat',
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLines: null,
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
                  text: 'Dokumen',
                  fontWeight: fBold,
                ),
                const SizedBox(height: 8.0),
                if (data.data!.attributes.documents != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      data.data!.attributes.documents!.length,
                      (idx) {
                        var e = data.data!.attributes.documents![idx];

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: BaseElevatedButton(
                            onPressed: () async {
                              var src = baseUrl;
                              var url = e.attributes.url;
                              var provider = e.attributes.provider;
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
                          ),
                        );
                      },
                    ).toList(),
                  ),
              ],
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
                  text: 'Detail Kegiatan',
                  type: 'h3',
                  fontWeight: fBold,
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<SuratPengajuanDetailCubit,
                  SuratPengajuanDetailState>(builder: (context, state) {
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
