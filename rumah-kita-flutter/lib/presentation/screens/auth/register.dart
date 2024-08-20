import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../service_locator.dart';
import '../../../utils/constants.dart';
import '../../../utils/themes.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/register/register_cubit.dart';
import '../../widgets/base_appbar.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_dialog.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_typography.dart';

/// RegisterScreen
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(
          lazy: false,
          create: (context) => sl<RegisterCubit>(),
        )
      ],
      child: _RegisterScreen(key: key),
    );
  }
}

class _RegisterScreen extends StatefulWidget {
  const _RegisterScreen({
    super.key,
  });

  @override
  State<_RegisterScreen> createState() => __RegisterScreenState();
}

class __RegisterScreenState extends State<_RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _domisiliController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  JenisKelamin _jenisKelamin = JenisKelamin.none;
  bool _hidePassword = true;

  void _resetInputs() {
    _nameController.text = '';
    _usernameController.text = '';
    _emailController.text = '';
    _rtController.text = '';
    _rwController.text = '';
    _addressController.text = '';
    _domisiliController.text = '';
    _passwordController.text = '';
    _jenisKelamin = JenisKelamin.none;
    _hidePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: cDarkBlue,
        body: MultiBlocListener(
          listeners: [
            BlocListener<RegisterCubit, RegisterState>(
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
                        text: 'Berhasil',
                        fontWeight: fLight,
                      ),
                    );
                    BlocProvider.of<AuthBloc>(context)
                        .add(const AuthStatusChanged());
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
                      text: 'Daftar',
                      type: 'h3',
                      fontWeight: fBold,
                      color: cWhite,
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTextField(
                    controller: _nameController,
                    onChanged: (val) {
                      BlocProvider.of<RegisterCubit>(context)
                          .fullnameChanged(val);
                    },
                    label: 'Nama Lengkap',
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
                    controller: _usernameController,
                    onChanged: (val) {
                      BlocProvider.of<RegisterCubit>(context)
                          .usernameChanged(val);
                    },
                    label: 'Username',
                    hintText: 'username',
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
                      BlocProvider.of<RegisterCubit>(context).emailChanged(val);
                    },
                    label: 'Email',
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
                      BlocProvider.of<RegisterCubit>(context).rtChanged(val);
                    },
                    label: 'RT (Rukun Tetangga)',
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
                      BlocProvider.of<RegisterCubit>(context).rwChanged(val);
                    },
                    label: 'RW (Rukun Warga)',
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
                      BlocProvider.of<RegisterCubit>(context)
                          .alamatChanged(val);
                    },
                    label: 'Alamat',
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
                  child: BaseTextField(
                    controller: _domisiliController,
                    onChanged: (val) {
                      BlocProvider.of<RegisterCubit>(context)
                          .domisiliChanged(val);
                    },
                    label: 'Domisili',
                    hintText: 'Jakarta Pusat',
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
                        color: cWhite,
                        fontWeight: fBold,
                      ),
                      const SizedBox(height: 8.0),
                      Wrap(
                        children: JenisKelamin.values.map((e) {
                          if (!e.isNone) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: BaseTypography(
                                text: e.toLabel(),
                                fontWeight: fBold,
                                color: cWhite,
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
                                    BlocProvider.of<RegisterCubit>(context)
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
                const SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTextField(
                    controller: _passwordController,
                    onChanged: (val) {
                      BlocProvider.of<RegisterCubit>(context)
                          .passwordChanged(val);
                    },
                    obscureText: _hidePassword,
                    label: 'Password',
                    hintText: 'password',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                      icon: Icon(
                        _hidePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return BaseElevatedButton(
                        onPressed: (state.status.isInProgress ||
                                state.status.isSuccess)
                            ? null
                            : () {
                                BlocProvider.of<RegisterCubit>(context)
                                    .formSubmitted();
                              },
                        borderRadius: 28.0,
                        label: 'Daftar',
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
