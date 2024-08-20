part of 'signal_cubit.dart';

enum Signal {
  none,
}

extension SignalX on Signal {
  bool get isNone => this == Signal.none;
}

class SignalState extends Equatable {
  final Signal signal;
  final int timestamp;

  const SignalState({
    this.signal = Signal.none,
    this.timestamp = 0,
  });

  @override
  List<Object?> get props => [signal, timestamp];
}
