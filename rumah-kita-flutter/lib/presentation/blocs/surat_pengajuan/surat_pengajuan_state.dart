part of 'surat_pengajuan_cubit.dart';

/// SuratPengajuanState
class SuratPengajuanState extends Equatable {
  final BlocState status;
  final List<SuratPengajuanModel> data;
  final ErrorObject? error;

  const SuratPengajuanState({
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

  SuratPengajuanState copyWith({
    BlocState? status,
    List<SuratPengajuanModel>? data,
    ErrorObject? error,
  }) {
    return SuratPengajuanState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }
}
