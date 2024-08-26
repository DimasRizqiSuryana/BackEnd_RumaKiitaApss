part of 'kegiatan_detail_cubit.dart';

/// KegiatanDetailState
class KegiatanDetailState extends Equatable {
  final BlocState status;
  final KegiatanModel? data;
  final ElectionRegistrationModel? userElection;
  final ErrorObject? error;

  const KegiatanDetailState({
    this.status = BlocState.initial,
    this.data,
    this.userElection,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        data,
        userElection,
        error,
      ];

  KegiatanDetailState copyWith({
    BlocState? status,
    KegiatanModel? data,
    ElectionRegistrationModel? userElection,
    ErrorObject? error,
  }) {
    return KegiatanDetailState(
      status: status ?? this.status,
      data: data ?? this.data,
      userElection: userElection ?? this.userElection,
      error: error,
    );
  }
}
