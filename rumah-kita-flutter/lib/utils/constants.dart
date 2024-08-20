const String baseUrl = String.fromEnvironment(
  'BASE_URL',
  defaultValue: 'http://localhost:1337',
);

/// BlocState
///
/// Basic BLoC State, avoid redundancy state model
enum BlocState {
  initial,
  loading,
  success,
  failure,
}

extension BlocStateX on BlocState {
  bool get isInitial => this == BlocState.initial;
  bool get isLoading => this == BlocState.loading;
  bool get isSuccess => this == BlocState.success;
  bool get isFailure => this == BlocState.failure;
}

/// JenisKelamin
enum JenisKelamin {
  none,
  male,
  female,
}

extension JenisKelaminX on JenisKelamin {
  bool get isNone => this == JenisKelamin.none;
  bool get isMale => this == JenisKelamin.male;
  bool get isFemale => this == JenisKelamin.female;

  String toStr() {
    if (isMale) {
      return 'laki-laki';
    } else if (isFemale) {
      return 'perempuan';
    } else {
      return '';
    }
  }

  String toLabel() {
    if (isMale) {
      return 'Laki-Laki';
    } else if (isFemale) {
      return 'Perempuan';
    } else {
      return '';
    }
  }
}

extension BackendAPIParser on String {
  JenisKelamin toJenisKelamin() {
    switch (toLowerCase()) {
      case "laki-laki":
        return JenisKelamin.male;
      case "perempuan":
        return JenisKelamin.female;
      default:
        return JenisKelamin.none;
    }
  }
}
