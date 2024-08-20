import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signal_state.dart';

/// SignalCubit
class SignalCubit extends Cubit<SignalState> {
  SignalCubit() : super(const SignalState());

  int _generateTimestamp(bool pauseTimestamp) {
    return pauseTimestamp ? state.timestamp : state.timestamp + 1;
  }

  void send(Signal signal, {bool pauseTimestamp = false}) {
    emit(SignalState(
      signal: signal,
      timestamp: _generateTimestamp(pauseTimestamp),
    ));
  }
}
