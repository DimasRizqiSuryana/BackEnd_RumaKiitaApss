part of 'surat_pengajuan_detail_cubit.dart';

/// SuratPengajuanDetailState
class SuratPengajuanDetailState extends Equatable {
  final BlocState status;
  final SuratPengajuanModel? data;
  final ErrorObject? error;

  const SuratPengajuanDetailState({
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

  SuratPengajuanDetailState copyWith({
    BlocState? status,
    SuratPengajuanModel? data,
    ErrorObject? error,
  }) {
    return SuratPengajuanDetailState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }
}
