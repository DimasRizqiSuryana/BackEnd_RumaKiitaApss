import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/document_status/document_status_model.dart';
import '../../../data/models/jenis_surat_pengajuan/jenis_surat_pengajuan_model.dart';
import '../../../data/models/kategori_kegiatan/kategori_kegiatan_model.dart';
import '../../../data/services/api/api.dart';

part 'boot_state.dart';

/// BootCubit
class BootCubit extends Cubit<BootState> {
  final DocumentStatusApi _documentStatusApi;
  final KategoriKegiatanApi _kategoriKegiatanApi;
  final JenisSuratPengajuanApi _jenisSuratPengajuanApi;

  final Set<String> _queue = {};

  BootCubit({
    required DocumentStatusApi documentStatusApi,
    required KategoriKegiatanApi kategoriKegiatanApi,
    required JenisSuratPengajuanApi jenisSuratPengajuanApi,
  })  : _documentStatusApi = documentStatusApi,
        _kategoriKegiatanApi = kategoriKegiatanApi,
        _jenisSuratPengajuanApi = jenisSuratPengajuanApi,
        super(const BootState());

  void scheduledQueue() async {
    emit(state.copyWith(status: BootStatus.running));

    var _ = await Future.wait([
      _documentStatuses(),
      _kategoriKegiatans(),
      _jenisSuratPengajuans(),
    ]);

    emit(state.copyWith(status: BootStatus.idle));
  }

  void start() {
    _queue.clear();
    _queue.addAll([
      'document_status',
      'kategori_kegiatan',
      'jenis_surat_pengajuan',
    ]);

    scheduledQueue();
  }

  Future<void> _documentStatuses() async {
    if (!_queue.contains('document_status')) return;

    final result = await _documentStatusApi.getAll(qp: {
      'pagination[pageSize]': 9999,
    });

    result.foldRight(null, (res, _) {
      emit(state.copyWith(documentStatus: res.data));
      _queue.remove('document_status');
    });
  }

  Future<void> _kategoriKegiatans() async {
    if (!_queue.contains('kategori_kegiatan')) return;

    final result = await _kategoriKegiatanApi.getAll(qp: {
      'populate[0]': 'cover',
      'pagination[pageSize]': 9999,
    });

    result.foldRight(null, (res, _) {
      emit(state.copyWith(kategoriKegiatan: res.data));
      _queue.remove('kategori_kegiatan');
    });
  }

  Future<void> _jenisSuratPengajuans() async {
    if (!_queue.contains('jenis_surat_pengajuan')) return;

    final result = await _jenisSuratPengajuanApi.getAll(qp: {
      'pagination[pageSize]': 9999,
    });

    result.foldRight(null, (res, _) {
      emit(state.copyWith(jenisSuratPengajuan: res.data));
      _queue.remove('jenis_surat_pengajuan');
    });
  }
}
