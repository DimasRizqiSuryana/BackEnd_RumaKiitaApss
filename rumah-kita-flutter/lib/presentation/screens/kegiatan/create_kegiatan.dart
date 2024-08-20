import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

import '../../../service_locator.dart';
import '../../../utils/helpers.dart';
import '../../../utils/themes.dart';
import '../../blocs/boot/boot_cubit.dart';
import '../../blocs/create_kegiatan/create_kegiatan_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_date_picker.dart';
import '../../widgets/base_dialog.dart';
import '../../widgets/base_dropdown_menu.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/img.dart';

/// CreateKegiatanScreen
class CreateKegiatanScreen extends StatelessWidget {
  const CreateKegiatanScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateKegiatanCubit>(
          lazy: false,
          create: (context) => sl<CreateKegiatanCubit>(),
        ),
      ],
      child: _CreateKegiatanScreen(
        key: key,
      ),
    );
  }
}

class _CreateKegiatanScreen extends StatefulWidget {
  const _CreateKegiatanScreen({
    super.key,
  });

  @override
  State<_CreateKegiatanScreen> createState() => __CreateKegiatanScreenState();
}

class __CreateKegiatanScreenState extends State<_CreateKegiatanScreen> {
  final TextEditingController _kategoriKegiatanController =
      TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _attachment;

  void _resetInputs() {
    _titleController.text = '';
    _descriptionController.text = '';
    setState(() {
      _attachment = null;
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<BootCubit>(context).scheduledQueue();

    final boot = BlocProvider.of<BootCubit>(context).state;

    for (var i = 0; i < boot.documentStatus.length; i++) {
      var e = boot.documentStatus[i];

      if (e.attributes.status == 'pending') {
        BlocProvider.of<CreateKegiatanCubit>(context)
            .documentStatusChanged(e.id);
        break;
      }
    }
  }

  @override
  void dispose() {
    _kategoriKegiatanController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: MultiBlocListener(
            listeners: [
              BlocListener<CreateKegiatanCubit, CreateKegiatanState>(
                listener: (context, state) {
                  if (state.validation != null) {
                    showInfoDialog(
                      context: context,
                      type: 'warning',
                      title: state.validation!.name,
                      body: state.validation!.message,
                    );
                  } else {
                    if (state.status.isSuccess) {
                      _resetInputs();
                      showSnackBar(
                        context: context,
                        content: const BaseTypography(
                          text: 'Kegiatan Berhasil Dibuat',
                          fontWeight: fLight,
                        ),
                      );
                    } else if (state.status.isFailure) {
                      showSnackBar(
                        context: context,
                        content: BaseTypography(
                          text: state.error!.message,
                          fontWeight: fLight,
                        ),
                      );
                    }
                  }
                },
              ),
            ],
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
                      text: 'Ajukan Kegiatan',
                      type: 'h3',
                      fontWeight: fBold,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            height: 180.0,
                            width: double.infinity,
                            color: cTeal,
                            child: Img.asset(
                              name: Assets.image('cs-2.png'),
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.bottomLeft,
                            ),
                          ),
                          const Positioned.fill(
                            right: 16.0,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: BaseTypography(
                                text: 'Ajukan kegiatan mu',
                                type: 'h3',
                                color: cWhite,
                                fontWeight: fBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: BlocBuilder<BootCubit, BootState>(
                          builder: (context, state) {
                            return BaseDropdownMenu<int>.outlined(
                              controller: _kategoriKegiatanController,
                              onSelected: (val) {
                                BlocProvider.of<CreateKegiatanCubit>(context)
                                    .kategoriKegiatanChanged(val ?? 0);
                              },
                              label: 'Kategori Kegiatan',
                              hintText: 'Kategori Kegiatan',
                              requestFocusOnTap: true,
                              dropdownMenuEntries:
                                  state.kategoriKegiatan.where((e) {
                                return e.attributes.kategori != 'pemilihan';
                              }).map((e) {
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
                          onChanged: (val) {
                            BlocProvider.of<CreateKegiatanCubit>(context)
                                .titleChanged(val);
                          },
                          label: 'Judul',
                          labelColor: cBlack,
                          hintText: 'Judul kegiatan',
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
                          onChanged: (val) {
                            BlocProvider.of<CreateKegiatanCubit>(context)
                                .descriptionChanged(val);
                          },
                          label: 'Keterangan',
                          labelColor: cBlack,
                          hintText: 'Keterangan',
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
                          onChanged: (val) {
                            var str = '';
                            if (val != null) {
                              str = val.toIso8601String();
                            }

                            BlocProvider.of<CreateKegiatanCubit>(context)
                                .startDateChanged(str);
                          },
                          label: 'Mulai Kegiatan',
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: BaseDatePicker(
                          onChanged: (val) {
                            var str = '';
                            if (val != null) {
                              str = val.toIso8601String();
                            }

                            BlocProvider.of<CreateKegiatanCubit>(context)
                                .finishDateChanged(str);
                          },
                          label: 'Selesai Kegiatan',
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
                            if (_attachment != null)
                              Row(
                                children: [
                                  Expanded(
                                    child: BaseTypography(
                                      text: p.basename(_attachment!.path),
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _attachment = null;
                                      });
                                      BlocProvider.of<CreateKegiatanCubit>(
                                              context)
                                          .attachmentChanged(_attachment);
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                const Spacer(),
                                BaseElevatedButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles();

                                    if (result != null && context.mounted) {
                                      setState(() {
                                        _attachment =
                                            File(result.files.single.path!);
                                      });
                                      BlocProvider.of<CreateKegiatanCubit>(
                                              context)
                                          .attachmentChanged(_attachment);
                                    }
                                  },
                                  label: 'Upload',
                                  fontSize: fParagraph,
                                  backgroundColor: cOrange,
                                  foregroundColor: cBlack,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24.0,
                        ),
                        child: BlocBuilder<CreateKegiatanCubit,
                            CreateKegiatanState>(
                          builder: (context, state) {
                            return BaseElevatedButton(
                              onPressed: (state.status.isInProgress ||
                                      state.status.isSuccess)
                                  ? null
                                  : () async {
                                      final res = await showActionConfirmDialog(
                                        context: context,
                                        confirmLabel: 'Buat',
                                        children: [
                                          const Center(
                                            child: BaseTypography(
                                              text: 'Buat Kegiatan',
                                              type: 'h3',
                                              textAlign: TextAlign.center,
                                              fontWeight: fBold,
                                            ),
                                          ),
                                          const SizedBox(height: 24.0),
                                          const Center(
                                            child: BaseTypography(
                                              text:
                                                  'Kamu yakin ingin melanjutkan?',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      );

                                      if (res && context.mounted) {
                                        BlocProvider.of<CreateKegiatanCubit>(
                                                context)
                                            .formSubmitted();
                                      }
                                    },
                              borderRadius: 32.0,
                              label: 'Buat',
                              backgroundColor: cTeal,
                              foregroundColor: cWhite,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 64.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
