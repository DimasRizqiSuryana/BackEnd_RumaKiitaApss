import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/helpers.dart';
import '../../../utils/themes.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/boot/boot_cubit.dart';
import '../../widgets/img.dart';

/// SplashSreen
class SplashSreen extends StatelessWidget {
  const SplashSreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _SplashScreen(key: key);
  }
}

class _SplashScreen extends StatefulWidget {
  const _SplashScreen({
    super.key,
  });

  @override
  State<_SplashScreen> createState() => __SplashScreenState();
}

class __SplashScreenState extends State<_SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BootCubit>(context).start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cTeal,
      body: BlocListener<BootCubit, BootState>(
        listenWhen: (_, current) {
          return current.status.isIdle;
        },
        listener: (context, state) {
          BlocProvider.of<AuthBloc>(context).add(const AuthStatusChanged());
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Img.asset(
            name: Assets.image('splash-img.png'),
            width: 160.0,
          ),
        ),
      ),
    );
  }
}
