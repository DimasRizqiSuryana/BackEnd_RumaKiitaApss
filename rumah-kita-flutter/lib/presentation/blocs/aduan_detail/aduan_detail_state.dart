part of 'aduan_detail_cubit.dart';

/// AduanDetailState
class AduanDetailState extends Equatable {
  final BlocState status;
  final AduanModel? data;
  final ErrorObject? error;

  const AduanDetailState({
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

  AduanDetailState copyWith({
    BlocState? status,
    AduanModel? data,
    ErrorObject? error,
  }) {
    return AduanDetailState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }
}
