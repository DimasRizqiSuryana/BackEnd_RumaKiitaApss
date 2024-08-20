import 'package:hive/hive.dart';

class AppKVS {
  final _apps = Hive.box('apps');

  String get jwtToken => _apps.get('jwt_token', defaultValue: '');

  set jwtToken(String val) => _apps.put('jwt_token', val);

  int? get userId => _apps.get('user_id', defaultValue: null);

  set userId(int? val) => _apps.put('user_id', val);

  int? get userDetailId => _apps.get('user_detail_id', defaultValue: null);

  set userDetailId(int? val) => _apps.put('user_detail_id', val);

  bool get isSetup => _apps.get('is_setup', defaultValue: false);

  set isSetup(bool val) => _apps.put('is_setup', val);
}
