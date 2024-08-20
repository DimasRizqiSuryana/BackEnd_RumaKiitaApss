import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../utils/logger.dart';

part 'me_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class MeModel extends Equatable {
  final int id;
  final String username;
  final String email;
  final String provider;
  final bool confirmed;
  final bool blocked;

  @JsonKey(name: 'user_detail')
  final MeDetailModel? detail;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  const MeModel({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    this.detail,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        provider,
        confirmed,
        blocked,
        detail,
        createdAt,
        updatedAt,
      ];

  factory MeModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$MeModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message: 'Failed to Parse `Map<String, dynamic>` into `MeModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$MeModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `MeModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class MeDetailModel extends Equatable {
  final int id;
  final String fullname;
  final String jenisKelamin;
  final String rw;
  final String rt;
  final String alamat;
  final String domisili;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'publishedAt')
  final String publishedAt;

  const MeDetailModel({
    required this.id,
    required this.fullname,
    required this.jenisKelamin,
    required this.rw,
    required this.rt,
    required this.alamat,
    required this.domisili,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        jenisKelamin,
        rw,
        rt,
        alamat,
        domisili,
        createdAt,
        updatedAt,
        publishedAt,
      ];

  factory MeDetailModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$MeDetailModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message: 'Failed to Parse `Map<String, dynamic>` into `MeDetailModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$MeDetailModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `MeDetailModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}
