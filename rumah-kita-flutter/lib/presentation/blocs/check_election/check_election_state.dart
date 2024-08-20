part of 'check_election_cubit.dart';

/// CheckElectionState
class CheckElectionState extends Equatable {
  final BlocState status;
  final ElectionRegistrationModel? data;
  final ErrorObject? error;

  const CheckElectionState({
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

  CheckElectionState copyWith({
    BlocState? status,
    ElectionRegistrationModel? data,
    ErrorObject? error,
  }) {
    return CheckElectionState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }
}
