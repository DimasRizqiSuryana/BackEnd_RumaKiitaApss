import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as p;

import '../../../utils/themes.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_date_picker.dart';
import '../../widgets/base_dropdown_menu.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_typography.dart';

/// KerjaBaktiScreen
class KerjaBaktiScreen extends StatelessWidget {
  final int id;

  const KerjaBaktiScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return _KerjaBaktiScreen(
      key: key,
      id: id,
    );
  }
}

class _KerjaBaktiScreen extends StatefulWidget {
  final int id;

  const _KerjaBaktiScreen({
    super.key,
    required this.id,
  });

  @override
  State<_KerjaBaktiScreen> createState() => __KerjaBaktiScreenState();
}

class __KerjaBaktiScreenState extends State<_KerjaBaktiScreen> {
  final TextEditingController _documentStatusController =
      TextEditingController();
  final TextEditingController _kategoriKegiatanController =
      TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _attachment;

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
                  text: 'Kerja Bakti',
                  type: 'h3',
                  fontWeight: fBold,
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: BaseDropdownMenu<int>.outlined(
                      controller: _documentStatusController,
                      onSelected: (val) {},
                      label: 'Status',
                      hintText: 'Status',
                      requestFocusOnTap: true,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: 1,
                          label: 'Option 1',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: BaseDropdownMenu<int>.outlined(
                      controller: _kategoriKegiatanController,
                      onSelected: (val) {},
                      label: 'Kategori Kegiatan',
                      hintText: 'Kategori Kegiatan',
                      requestFocusOnTap: true,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: 1,
                          label: 'Option 1',
                        )
                      ],
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
                      onChanged: (val) {},
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
                  const SizedBox(height: 64.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
