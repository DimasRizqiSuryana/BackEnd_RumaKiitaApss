part of 'election_party_cubit.dart';

/// ElectionPartyState
class ElectionPartyState extends Equatable {
  final BlocState status;
  final ElectionPartyModel? data;
  final ErrorObject? error;

  const ElectionPartyState({
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

  ElectionPartyState copyWith({
    BlocState? status,
    ElectionPartyModel? data,
    ErrorObject? error,
  }) {
    return ElectionPartyState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }
}
