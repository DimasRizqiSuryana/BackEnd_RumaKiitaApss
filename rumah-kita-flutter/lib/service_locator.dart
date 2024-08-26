import 'package:get_it/get_it.dart';

import 'data/services/api/api.dart';
import 'data/services/key_value_store/key_value_store.dart';
import 'presentation/blocs/aduan/aduan_cubit.dart';
import 'presentation/blocs/aduan_detail/aduan_detail_cubit.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/boot/boot_cubit.dart';
import 'presentation/blocs/check_election/check_election_cubit.dart';
import 'presentation/blocs/create_aduan/create_aduan_cubit.dart';
import 'presentation/blocs/create_kegiatan/create_kegiatan_cubit.dart';
import 'presentation/blocs/create_surat_pengajuan/create_surat_pengajuan_cubit.dart';
import 'presentation/blocs/edit_profile/edit_profile_cubit.dart';
import 'presentation/blocs/election_party/election_party_cubit.dart';
import 'presentation/blocs/election_registration/election_registration_cubit.dart';
import 'presentation/blocs/kegiatan/kegiatan_cubit.dart';
import 'presentation/blocs/kegiatan_detail/kegiatan_detail_cubit.dart';
import 'presentation/blocs/login/login_cubit.dart';
import 'presentation/blocs/register/register_cubit.dart';
import 'presentation/blocs/signal/signal_cubit.dart';
import 'presentation/blocs/surat_pengajuan/surat_pengajuan_cubit.dart';
import 'presentation/blocs/surat_pengajuan_detail/surat_pengajuan_detail_cubit.dart';
import 'utils/dio_client.dart';

final sl = GetIt.instance;

/// Initialize service locator
void init() {
  // Utils
  sl.registerLazySingleton(() => DioClient(appKVS: sl()));

  // key-value store services
  sl.registerLazySingleton<AppKVS>(() => AppKVS());

  // API services
  sl.registerLazySingleton<AuthApi>(
      () => AuthApi(dioClient: sl(), appKVS: sl()));
  sl.registerLazySingleton<AduanApi>(() => AduanApi(dioClient: sl()));
  sl.registerLazySingleton<DocumentStatusApi>(
      () => DocumentStatusApi(dioClient: sl()));
  sl.registerLazySingleton<ElectionPartyApi>(
      () => ElectionPartyApi(dioClient: sl()));
  sl.registerLazySingleton<ElectionRegistrationApi>(
      () => ElectionRegistrationApi(dioClient: sl()));
  sl.registerLazySingleton<ElectionVoterApi>(
      () => ElectionVoterApi(dioClient: sl()));
  sl.registerLazySingleton<ElectionApi>(() => ElectionApi(dioClient: sl()));
  sl.registerLazySingleton<JenisSuratPengajuanApi>(
      () => JenisSuratPengajuanApi(dioClient: sl()));
  sl.registerLazySingleton<KategoriKegiatanApi>(
      () => KategoriKegiatanApi(dioClient: sl()));
  sl.registerLazySingleton<KegiatanApi>(() => KegiatanApi(dioClient: sl()));
  sl.registerLazySingleton<KerjaBaktiApi>(() => KerjaBaktiApi(dioClient: sl()));
  sl.registerLazySingleton<SuratPengajuanApi>(
      () => SuratPengajuanApi(dioClient: sl()));
  sl.registerLazySingleton<UserDetailApi>(() => UserDetailApi(dioClient: sl()));
  sl.registerLazySingleton<UserApi>(() => UserApi(dioClient: sl()));

  // blocs
  sl.registerLazySingleton(() => BootCubit(
        documentStatusApi: sl(),
        jenisSuratPengajuanApi: sl(),
        kategoriKegiatanApi: sl(),
      ));
  sl.registerLazySingleton(() => SignalCubit());
  sl.registerLazySingleton(() => AuthBloc(appKVS: sl(), authApi: sl()));
  sl.registerFactory(() => RegisterCubit(
        authApi: sl(),
        appKVS: sl(),
        userDetailApi: sl(),
      ));
  sl.registerFactory(() => LoginCubit(authApi: sl()));
  sl.registerFactory(() => EditProfileCubit(
        appKVS: sl(),
        userApi: sl(),
        userDetailApi: sl(),
      ));
  sl.registerFactory(() => KegiatanCubit(kegiatanApi: sl()));
  sl.registerFactory(() => KegiatanDetailCubit(
        appKVS: sl(),
        kegiatanApi: sl(),
        electionRegistrationApi: sl(),
      ));
  sl.registerFactory(() => CreateKegiatanCubit(
        appKVS: sl(),
        kegiatanApi: sl(),
      ));
  sl.registerFactory(() => AduanCubit(aduanApi: sl()));
  sl.registerFactory(() => AduanDetailCubit(aduanApi: sl()));
  sl.registerFactory(() => CreateAduanCubit(
        appKVS: sl(),
        aduanApi: sl(),
      ));
  sl.registerFactory(() => SuratPengajuanCubit(suratPengajuan: sl()));
  sl.registerFactory(() => SuratPengajuanDetailCubit(suratPengajuanApi: sl()));
  sl.registerFactory(() => CreateSuratPengajuanCubit(
        appKVS: sl(),
        suratPengajuanApi: sl(),
      ));
  sl.registerFactory(() => ElectionPartyCubit(electionPartyApi: sl()));
  sl.registerFactory(() => CheckElectionCubit(electionRegistrationApi: sl()));
  sl.registerFactory(() => ElectionRegistrationCubit(
        appKVS: sl(),
        electionRegistrationApi: sl(),
        electionVoterApi: sl(),
      ));
}
