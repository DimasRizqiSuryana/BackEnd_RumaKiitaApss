part of 'kegiatan_cubit.dart';

/// KegiatanState
class KegiatanState extends Equatable {
  final BlocState status;
  final List<KegiatanModel> data;
  final ErrorObject? error;

  const KegiatanState({
    this.status = BlocState.initial,
    this.data = const [],
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        data,
        error,
      ];

  KegiatanState copyWith({
    BlocState? status,
    List<KegiatanModel>? data,
    ErrorObject? error,
  }) {
    return KegiatanState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }
}
