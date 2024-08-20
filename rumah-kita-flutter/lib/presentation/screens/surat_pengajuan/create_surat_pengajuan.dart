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
import '../../blocs/create_surat_pengajuan/create_surat_pengajuan_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_dialog.dart';
import '../../widgets/base_dropdown_menu.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/img.dart';

/// CreateSuratPengajuanScreen
class CreateSuratPengajuanScreen extends StatelessWidget {
  const CreateSuratPengajuanScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateSuratPengajuanCubit>(
          lazy: false,
          create: (context) => sl<CreateSuratPengajuanCubit>(),
        ),
      ],
      child: _CreateSuratPengajuanScreen(
        key: key,
      ),
    );
  }
}

class _CreateSuratPengajuanScreen extends StatefulWidget {
  const _CreateSuratPengajuanScreen({
    super.key,
  });

  @override
  State<_CreateSuratPengajuanScreen> createState() =>
      __CreateSuratPengajuanScreenState();
}

class __CreateSuratPengajuanScreenState
    extends State<_CreateSuratPengajuanScreen> {
  final TextEditingController _jenisSuratPengajuanController =
      TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  List<File> _documents = [];

  void _resetInputs() {
    _jenisSuratPengajuanController.text = '';
    _fullnameController.text = '';
    _alamatController.text = '';
    setState(() {
      _documents = [];
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
        BlocProvider.of<CreateSuratPengajuanCubit>(context)
            .documentStatusChanged(e.id);
        break;
      }
    }
  }

  @override
  void dispose() {
    _jenisSuratPengajuanController.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _alamatController.dispose();

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
              BlocListener<CreateSuratPengajuanCubit,
                  CreateSuratPengajuanState>(
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
                          text: 'Surat Pengajuan Berhasil Dibuat',
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
                      text: 'Buat Surat Pengajuan',
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
                              name: Assets.image('cs-4.png'),
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.bottomLeft,
                            ),
                          ),
                          const Positioned.fill(
                            right: 16.0,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: BaseTypography(
                                text: 'Buat Surat\nPengajuan',
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
                              controller: _jenisSuratPengajuanController,
                              onSelected: (val) {
                                BlocProvider.of<CreateSuratPengajuanCubit>(
                                        context)
                                    .jenisSuratPengajuanChanged(val ?? 0);
                              },
                              label: 'Jenis Surat',
                              hintText: 'Jenis Surat',
                              requestFocusOnTap: true,
                              dropdownMenuEntries:
                                  state.jenisSuratPengajuan.map((e) {
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
                          onChanged: (val) {
                            BlocProvider.of<CreateSuratPengajuanCubit>(context)
                                .fullnameChanged(val);
                          },
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
                          onChanged: (val) {
                            BlocProvider.of<CreateSuratPengajuanCubit>(context)
                                .emailChanged(val);
                          },
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
                          onChanged: (val) {
                            BlocProvider.of<CreateSuratPengajuanCubit>(context)
                                .alamatChanged(val);
                          },
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
                              text: 'Attachment',
                              fontWeight: fBold,
                            ),
                            const SizedBox(height: 8.0),
                            for (final (idx, d) in _documents.indexed)
                              Row(
                                children: [
                                  Expanded(
                                    child: BaseTypography(
                                      text: p.basename(d.path),
                                    ),
                                  ),
                                  const SizedBox(width: 12.0),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _documents.removeAt(idx);
                                      });
                                      BlocProvider.of<
                                                  CreateSuratPengajuanCubit>(
                                              context)
                                          .documentsChanged(_documents);
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
                                        _documents.add(
                                            File(result.files.single.path!));
                                      });
                                      BlocProvider.of<
                                                  CreateSuratPengajuanCubit>(
                                              context)
                                          .documentsChanged(_documents);
                                    }
                                  },
                                  label: 'Add File',
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
                        child: BlocBuilder<CreateSuratPengajuanCubit,
                            CreateSuratPengajuanState>(
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
                                              text: 'Buat Surat Pengajuan',
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
                                        BlocProvider.of<
                                                    CreateSuratPengajuanCubit>(
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
