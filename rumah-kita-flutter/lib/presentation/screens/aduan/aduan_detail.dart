import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../blocs/aduan_detail/aduan_detail_cubit.dart';
import '../../blocs/boot/boot_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_date_picker.dart';
import '../../widgets/base_dropdown_menu.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_typography.dart';

/// AduanDetailScreen
class AduanDetailScreen extends StatelessWidget {
  final int id;

  const AduanDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AduanDetailCubit>(
          lazy: false,
          create: (context) => sl<AduanDetailCubit>(),
        ),
      ],
      child: _AduanDetailScreen(
        key: key,
        id: id,
      ),
    );
  }
}

class _AduanDetailScreen extends StatefulWidget {
  final int id;

  const _AduanDetailScreen({
    super.key,
    required this.id,
  });

  @override
  State<_AduanDetailScreen> createState() => __AduanDetailScreenState();
}

class __AduanDetailScreenState extends State<_AduanDetailScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  void _fetch() {
    BlocProvider.of<BootCubit>(context).scheduledQueue();
    BlocProvider.of<AduanDetailCubit>(context).dataRequested(widget.id);
  }

  @override
  void initState() {
    super.initState();

    _fetch();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();

    super.dispose();
  }

  Widget _inProgressWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _failureWidget(AduanDetailState state) {
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

  Widget _successWidget(AduanDetailState data) {
    _titleController.text = data.data!.attributes.title;
    _descriptionController.text = data.data!.attributes.description;
    _locationController.text = data.data!.attributes.location;

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
            child: BlocBuilder<BootCubit, BootState>(
              builder: (context, state) {
                return BaseDropdownMenu<int>.outlined(
                  initialSelection: data.data!.attributes.documentStatus!.id,
                  onSelected: (val) {},
                  enabled: false,
                  label: 'Status',
                  hintText: 'Status',
                  requestFocusOnTap: true,
                  dropdownMenuEntries: state.documentStatus.map((e) {
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
              controller: _titleController,
              onChanged: (val) {},
              enabled: false,
              label: 'Judul',
              labelColor: cBlack,
              hintText: 'Judul laporan',
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
              controller: _descriptionController,
              onChanged: (val) {},
              enabled: false,
              label: 'Keterangan',
              labelColor: cBlack,
              hintText: 'Keterangan',
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
              controller: _locationController,
              onChanged: (val) {},
              enabled: false,
              label: 'Lokasi',
              labelColor: cBlack,
              hintText: 'Lokasi',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: BaseDatePicker(
              initialDatetime:
                  DateTime.parse(data.data!.attributes.dateOfIncident),
              onChanged: (val) {},
              enabled: false,
              label: 'Waktu Kejadian',
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
                  text: 'Attachment',
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
              child: BlocBuilder<AduanDetailCubit, AduanDetailState>(
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
