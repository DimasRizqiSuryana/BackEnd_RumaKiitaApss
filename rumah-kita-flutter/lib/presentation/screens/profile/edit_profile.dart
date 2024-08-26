import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/edit_profile/edit_profile_cubit.dart';
import '../../blocs/edit_profile_picture/edit_profile_picture_cubit.dart';
import '../../widgets/avatar.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_dialog.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/img.dart';

/// EditProfileScreen
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EditProfileCubit>(
          lazy: false,
          create: (context) => sl<EditProfileCubit>(),
        ),
        BlocProvider<EditProfilePictureCubit>(
          lazy: false,
          create: (context) => sl<EditProfilePictureCubit>(),
        )
      ],
      child: _EditProfileScreen(key: key),
    );
  }
}

class _EditProfileScreen extends StatefulWidget {
  const _EditProfileScreen({
    super.key,
  });

  @override
  State<_EditProfileScreen> createState() => __EditProfileScreenState();
}

class __EditProfileScreenState extends State<_EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _domisiliController = TextEditingController();
  JenisKelamin _jenisKelamin = JenisKelamin.none;
  FileMetadata? _photo;

  @override
  void initState() {
    super.initState();
    final user = BlocProvider.of<AuthBloc>(context).state.user!;

    _nameController.text = user.detail!.fullname;
    _emailController.text = user.email;
    _rtController.text = user.detail!.rt;
    _rwController.text = user.detail!.rw;
    _addressController.text = user.detail!.alamat;
    _domisiliController.text = user.detail!.domisili;
    _jenisKelamin = user.detail!.jenisKelamin.toJenisKelamin();

    if (user.detail!.photo != null) {
      _photo = user.detail!.photo!.toFileMetadata();
    }

    BlocProvider.of<EditProfileCubit>(context)
        .fullnameChanged(user.detail!.fullname);
    BlocProvider.of<EditProfileCubit>(context).emailChanged(user.email);
    BlocProvider.of<EditProfileCubit>(context).rtChanged(user.detail!.rt);
    BlocProvider.of<EditProfileCubit>(context).rwChanged(user.detail!.rw);
    BlocProvider.of<EditProfileCubit>(context)
        .alamatChanged(user.detail!.alamat);
    BlocProvider.of<EditProfileCubit>(context)
        .domisiliChanged(user.detail!.domisili);
    BlocProvider.of<EditProfileCubit>(context)
        .jenisKelaminChanged(_jenisKelamin.toStr());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: MultiBlocListener(
          listeners: [
            BlocListener<EditProfilePictureCubit, EditProfilePictureState>(
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
                    BlocProvider.of<AuthBloc>(context)
                        .add(const AuthStatusChanged(redirect: false));
                    showSnackBar(
                      context: context,
                      content: const BaseTypography(
                        text: 'Foto profile berhasil diubah',
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
            BlocListener<EditProfileCubit, EditProfileState>(
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
                    BlocProvider.of<AuthBloc>(context)
                        .add(const AuthStatusChanged(redirect: false));
                    showSnackBar(
                      context: context,
                      content: const BaseTypography(
                        text: 'Disimpan',
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
          child: SafeArea(
            child: ListView(
              children: [
                RumahKitaAppBar(
                  backgroundColor: cDarkBlue,
                  left: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: cWhite,
                      ),
                    )
                  ],
                  middle: const [
                    BaseTypography(
                      text: 'Edit Profil',
                      type: 'h3',
                      fontWeight: fBold,
                      color: cWhite,
                    ),
                  ],
                ),
                Container(
                  color: cDarkBlue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 64.0,
                    horizontal: 24.0,
                  ),
                  child: Column(
                    children: [
                      Avatar(
                        avatar: _photo,
                        size: 96.0,
                      ),
                      const SizedBox(height: 24.0),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return BaseTypography(
                            text: state.user!.detail!.fullname,
                            type: 'h2',
                            color: cWhite,
                          );
                        },
                      ),
                      const SizedBox(height: 8.0),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return BaseTypography(
                            text:
                                'RT/RW: ${state.user!.detail!.rt}/${state.user!.detail!.rw}',
                            color: cWhite,
                            fontWeight: fLight,
                          );
                        },
                      ),
                      const SizedBox(height: 24.0),
                      BaseElevatedButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );

                          if (result != null && context.mounted) {
                            var f = File(result.files.single.path!);
                            setState(() {
                              _photo = FileMetadata.local(source: f.path);
                            });
                            BlocProvider.of<EditProfilePictureCubit>(context)
                                .photoChanged(f);
                          }
                        },
                        padding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 16.0,
                        ),
                        label: 'Ganti foto profil',
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 32.0,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: cDarkBlue,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(
                                64.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTextField(
                    controller: _nameController,
                    onChanged: (val) {
                      BlocProvider.of<EditProfileCubit>(context)
                          .fullnameChanged(val);
                    },
                    label: 'Nama Lengkap',
                    labelColor: cBlack,
                    hintText: 'Nama Lengkap Kamu',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTextField(
                    controller: _emailController,
                    onChanged: (val) {
                      BlocProvider.of<EditProfileCubit>(context)
                          .emailChanged(val);
                    },
                    label: 'Email',
                    labelColor: cBlack,
                    hintText: 'example@mail.com',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTextField(
                    controller: _rtController,
                    onChanged: (val) {
                      BlocProvider.of<EditProfileCubit>(context).rtChanged(val);
                    },
                    label: 'RT (Rukun Tetangga)',
                    labelColor: cBlack,
                    hintText: '001',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTextField(
                    controller: _rwController,
                    onChanged: (val) {
                      BlocProvider.of<EditProfileCubit>(context).rwChanged(val);
                    },
                    label: 'RW (Rukun Warga)',
                    labelColor: cBlack,
                    hintText: '001',
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    filled: true,
                  ),
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTextField(
                    controller: _addressController,
                    onChanged: (val) {
                      BlocProvider.of<EditProfileCubit>(context)
                          .alamatChanged(val);
                    },
                    label: 'Alamat',
                    labelColor: cBlack,
                    hintText: 'Jl. Nasional',
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    maxLines: null,
                    filled: true,
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
                        text: 'Jenis Kelamin',
                        color: cBlack,
                        fontWeight: fBold,
                      ),
                      const SizedBox(height: 8.0),
                      Wrap(
                        // spacing: 12.0,
                        // runSpacing: 12.0,
                        children: JenisKelamin.values.map((e) {
                          if (!e.isNone) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: BaseTypography(
                                text: e.toLabel(),
                                fontWeight: fBold,
                              ),
                              leading: Radio<JenisKelamin>(
                                activeColor: cOrange,
                                value: e,
                                groupValue: _jenisKelamin,
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _jenisKelamin = val;
                                    });
                                    BlocProvider.of<EditProfileCubit>(context)
                                        .jenisKelaminChanged(val.toStr());
                                  }
                                },
                              ),
                            );
                          }

                          return const SizedBox.shrink();
                        }).toList(),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      return BaseElevatedButton(
                        onPressed: (state.status.isInProgress ||
                                state.status.isSuccess)
                            ? null
                            : () {
                                BlocProvider.of<EditProfileCubit>(context)
                                    .formSubmitted();
                              },
                        borderRadius: 28.0,
                        backgroundColor: cTeal,
                        foregroundColor: cWhite,
                        label: 'Simpan',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 64.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
