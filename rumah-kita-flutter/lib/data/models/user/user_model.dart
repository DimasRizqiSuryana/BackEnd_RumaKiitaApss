import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../utils/logger.dart';
import '../../../utils/extensions.dart';
import '../user_detail/user_detail_model.dart';
import '../utils.dart';

part 'user_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class UserListModel extends Equatable {
  final List<UserModel> data;
  final MetadataModel? meta;

  const UserListModel({
    required this.data,
    this.meta,
  });

  @override
  List<Object?> get props => [
        data,
        meta,
      ];

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$UserListModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message: 'Failed to Parse `Map<String, dynamic>` into `UserListModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$UserListModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `UserListModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class UserModel extends Equatable {
  final int id;
  final UserAttributeModel attributes;

  const UserModel({
    required this.id,
    required this.attributes,
  });

  @override
  List<Object?> get props => [
        id,
        attributes,
      ];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$UserModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message: 'Failed to Parse `Map<String, dynamic>` into `UserModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$UserModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `UserModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class UserAttributeModel extends Equatable {
  final String username;
  final String email;
  final String provider;
  final bool confirmed;
  final bool blocked;

  @NestedJsonKey(name: 'user_detail/data')
  final UserDetailModel? detail;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  const UserAttributeModel({
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.detail,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        username,
        email,
        provider,
        confirmed,
        blocked,
        detail,
        createdAt,
        updatedAt,
      ];

  factory UserAttributeModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$UserAttributeModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `UserAttributeModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$UserAttributeModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `UserAttributeModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}
