part of 'kegiatan_detail_cubit.dart';

/// KegiatanDetailState
class KegiatanDetailState extends Equatable {
  final BlocState status;
  final KegiatanModel? data;
  final ErrorObject? error;

  const KegiatanDetailState({
    this.status = BlocState.initial,
    this.data,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        data,
        error,
      ];

  KegiatanDetailState copyWith({
    BlocState? status,
    KegiatanModel? data,
    ErrorObject? error,
  }) {
    return KegiatanDetailState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }
}
