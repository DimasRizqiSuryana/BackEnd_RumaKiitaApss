import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../presentation/layouts/home.dart';
import '../presentation/screens/aduan/aduan_detail.dart';
import '../presentation/screens/aduan/create_aduan.dart';
import '../presentation/screens/auth/login.dart';
import '../presentation/screens/auth/register.dart';
import '../presentation/screens/dashboard/dashboard.dart';
import '../presentation/screens/inbox/inbox.dart';
import '../presentation/screens/inbox/inbox_aduan.dart';
import '../presentation/screens/inbox/inbox_kegiatan.dart';
import '../presentation/screens/inbox/inbox_pengajuan_surat.dart';
import '../presentation/screens/kegiatan/create_kegiatan.dart';
import '../presentation/screens/kegiatan/kegiatan.dart';
import '../presentation/screens/kegiatan/kegiatan_detail.dart';
import '../presentation/screens/kegiatan/kerja_bakti.dart';
import '../presentation/screens/kegiatan/kerja_bakti_documentation.dart';
import '../presentation/screens/kegiatan/pemilihan.dart';
import '../presentation/screens/profile/edit_profile.dart';
import '../presentation/screens/profile/profile.dart';
import '../presentation/screens/splash/splash.dart';
import '../presentation/screens/surat_pengajuan/create_surat_pengajuan.dart';
import '../presentation/screens/surat_pengajuan/surat_pengajuan_detail.dart';
import '../presentation/screens/welcome/welcome.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> inboxNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'inbox');

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashSreen(),
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      navigatorKey: homeNavigatorKey,
      builder: (context, state, child) {
        return HomeLayout(child: child);
      },
      routes: [
        ShellRoute(
          navigatorKey: inboxNavigatorKey,
          builder: (context, state, child) {
            return InboxScreen(child: child);
          },
          routes: [
            GoRoute(
              path: '/inbox-kegiatan',
              builder: (context, state) => const InboxKegiatanSection(),
            ),
            GoRoute(
              path: '/inbox-aduan',
              builder: (context, state) => const InboxAduanSection(),
            ),
            GoRoute(
              path: '/inbox-pengajuan-surat',
              builder: (context, state) => const InboxPengajuanSuratSection(),
            ),
          ],
        ),
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/kegiatan/:kategori',
      builder: (context, state) {
        return KegiatanScreen(
          kategoriKegiatan: state.pathParameters['kategori']!,
          title: state.uri.queryParameters['title'] ?? '',
          banner: state.uri.queryParameters['banner'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/kegiatan-detail/:id',
      builder: (context, state) => KegiatanDetailScreen(
        id: int.tryParse(state.pathParameters['id']!) ?? 0,
      ),
    ),
    GoRoute(
      path: '/kegiatan/kerja-bakti/:id',
      builder: (context, state) => KerjaBaktiScreen(
        id: int.tryParse(state.pathParameters['id']!) ?? 0,
      ),
    ),
    GoRoute(
      path: '/kegiatan/kerja-bakti/documentation/:id',
      builder: (context, state) => KerjaBaktiDocumentationSreen(
        id: int.tryParse(state.pathParameters['id']!) ?? 0,
      ),
    ),
    GoRoute(
      path: '/kegiatan/pemilihan/:id',
      builder: (context, state) => PemilihanScreen(
        id: int.tryParse(state.pathParameters['id']!) ?? 0,
      ),
    ),
    GoRoute(
      path: '/create-kegiatan',
      builder: (context, state) => const CreateKegiatanScreen(),
    ),
    GoRoute(
      path: '/aduan-detail/:id',
      builder: (context, state) => AduanDetailScreen(
        id: int.tryParse(state.pathParameters['id']!) ?? 0,
      ),
    ),
    GoRoute(
      path: '/create-aduan',
      builder: (context, state) => const CreateAduanScreen(),
    ),
    GoRoute(
      path: '/surat-pengajuan-detail/:id',
      builder: (context, state) => SuratPengajuanDetailScreen(
        id: int.tryParse(state.pathParameters['id']!) ?? 0,
      ),
    ),
    GoRoute(
      path: '/create-surat-pengajuan',
      builder: (context, state) => const CreateSuratPengajuanScreen(),
    ),
  ],
);
