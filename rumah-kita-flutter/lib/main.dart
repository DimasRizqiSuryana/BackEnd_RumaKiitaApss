import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/boot/boot_cubit.dart';
import 'presentation/blocs/signal/signal_cubit.dart';
import 'presentation/widgets/base_snackbar.dart';
import 'presentation/widgets/base_typography.dart';
import 'service_locator.dart' as service_locator;
import 'service_locator.dart';
import 'utils/routes.dart';
import 'utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();
  await Hive.openBox('apps');
  service_locator.init();

  const App app = App();
  runApp(app);
}

class App extends StatefulWidget {
  const App({
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignalCubit>(
          create: (context) => sl<SignalCubit>(),
        ),
        BlocProvider<BootCubit>(
          create: (context) => sl<BootCubit>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: RumahKitaTheme.light,
        title: 'RumahKita',
        builder: (context, child) {
          return MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state.error != null) {
                    showSnackBar(
                      context: context,
                      content: BaseTypography(
                        text: state.error!.message,
                      ),
                    );
                  }

                  if (state.redirect && state.status.isUnauthenticated) {
                    router.go('/welcome');
                  } else if (state.redirect && state.status.isAuthenticated) {
                    final boot = BlocProvider.of<BootCubit>(context).state;
                    if (boot.status.isIdle) {
                      BlocProvider.of<BootCubit>(context).scheduledQueue();
                    }

                    router.go('/dashboard');
                  }
                },
              ),
            ],
            child: child!,
          );
        },
      ),
    );
  }
}
