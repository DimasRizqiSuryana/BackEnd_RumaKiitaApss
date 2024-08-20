part of 'boot_cubit.dart';

/// BootStatus
enum BootStatus { initial, running, idle }

extension BootStatusX on BootStatus {
  bool get isInitial => this == BootStatus.initial;
  bool get isRunning => this == BootStatus.running;
  bool get isIdle => this == BootStatus.idle;
}

/// BootState
class BootState extends Equatable {
  final BootStatus status;
  final List<DocumentStatusModel> documentStatus;
  final List<KategoriKegiatanModel> kategoriKegiatan;
  final List<JenisSuratPengajuanModel> jenisSuratPengajuan;

  const BootState({
    this.status = BootStatus.initial,
    this.documentStatus = const [],
    this.kategoriKegiatan = const [],
    this.jenisSuratPengajuan = const [],
  });

  @override
  List<Object?> get props => [
        status,
        documentStatus,
        kategoriKegiatan,
        jenisSuratPengajuan,
      ];

  BootState copyWith({
    BootStatus? status,
    List<DocumentStatusModel>? documentStatus,
    List<KategoriKegiatanModel>? kategoriKegiatan,
    List<JenisSuratPengajuanModel>? jenisSuratPengajuan,
  }) {
    return BootState(
      status: status ?? this.status,
      documentStatus: documentStatus ?? this.documentStatus,
      kategoriKegiatan: kategoriKegiatan ?? this.kategoriKegiatan,
      jenisSuratPengajuan: jenisSuratPengajuan ?? this.jenisSuratPengajuan,
    );
  }
}
