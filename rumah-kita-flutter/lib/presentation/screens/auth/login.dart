import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../service_locator.dart';
import '../../../utils/helpers.dart';
import '../../../utils/themes.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/login/login_cubit.dart';
import '../../widgets/base_buttons.dart';
import '../../widgets/base_dialog.dart';
import '../../widgets/base_snackbar.dart';
import '../../widgets/base_text_field.dart';
import '../../widgets/base_typography.dart';
import '../../widgets/img.dart';

/// LoginScreen
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          lazy: false,
          create: (context) => sl<LoginCubit>(),
        )
      ],
      child: _LoginScreen(key: key),
    );
  }
}

class _LoginScreen extends StatefulWidget {
  const _LoginScreen({
    super.key,
  });

  @override
  State<_LoginScreen> createState() => __LoginScreenState();
}

class __LoginScreenState extends State<_LoginScreen> {
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hidePassword = true;

  void _resetInputs() {
    _identifierController.text = '';
    _passwordController.text = '';
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
            BlocListener<LoginCubit, LoginState>(
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
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32.0,
                    horizontal: 24.0,
                  ),
                  decoration: const BoxDecoration(
                    color: cTeal,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      Img.asset(name: Assets.image('login-img.png')),
                      const SizedBox(height: 24.0),
                      const BaseTypography(
                        text: 'Login',
                        type: 'h1',
                        fontWeight: fBold,
                        color: cWhite,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 64.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTextField(
                    controller: _identifierController,
                    onChanged: (val) {
                      BlocProvider.of<LoginCubit>(context)
                          .identifierChanged(val);
                    },
                    label: 'Username / Email',
                    hintText: 'Username / Email',
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
                    controller: _passwordController,
                    onChanged: (val) {
                      BlocProvider.of<LoginCubit>(context).passwordChanged(val);
                    },
                    obscureText: _hidePassword,
                    label: 'Password',
                    hintText: 'Password',
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
                  child: BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return BaseElevatedButton(
                        onPressed: (state.status.isInProgress ||
                                state.status.isSuccess)
                            ? null
                            : () {
                                BlocProvider.of<LoginCubit>(context)
                                    .formSubmitted();
                              },
                        borderRadius: 28.0,
                        label: 'Masuk',
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: BaseTypography.richText(
                    color: cWhite,
                    fontWeight: fLight,
                    textAlign: TextAlign.center,
                    children: [
                      const TextSpan(text: 'Belum memiliki akun? '),
                      TextSpan(
                        text: 'Daftar',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.push('/register');
                          },
                      ),
                    ],
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
