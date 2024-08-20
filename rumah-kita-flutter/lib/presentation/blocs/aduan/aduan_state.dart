part of 'aduan_cubit.dart';

/// AduanState
class AduanState extends Equatable {
  final BlocState status;
  final List<AduanModel> data;
  final ErrorObject? error;

  const AduanState({
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

  AduanState copyWith({
    BlocState? status,
    List<AduanModel>? data,
    ErrorObject? error,
  }) {
    return AduanState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }
}
