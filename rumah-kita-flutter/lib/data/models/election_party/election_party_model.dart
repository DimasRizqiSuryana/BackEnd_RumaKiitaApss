import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../utils/logger.dart';
import '../../../utils/extensions.dart';
import '../media/media_model.dart';
import '../utils.dart';

part 'election_party_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class ElectionPartyListModel extends Equatable {
  final List<ElectionPartyModel> data;
  final MetadataModel? meta;

  const ElectionPartyListModel({
    required this.data,
    this.meta,
  });

  @override
  List<Object?> get props => [
        data,
        meta,
      ];

  factory ElectionPartyListModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$ElectionPartyListModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `ElectionPartyListModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$ElectionPartyListModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `ElectionPartyListModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class ElectionPartyModel extends Equatable {
  final int id;
  final ElectionPartyAttributeModel attributes;

  const ElectionPartyModel({
    required this.id,
    required this.attributes,
  });

  @override
  List<Object?> get props => [
        id,
        attributes,
      ];

  factory ElectionPartyModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$ElectionPartyModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `ElectionPartyModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$ElectionPartyModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `ElectionPartyModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class ElectionPartyAttributeModel extends Equatable {
  final int noUrut;
  final String ketua;

  @NestedJsonKey(name: 'photo_ketua/data')
  final MediaModel? photoKetua;

  final String wakilKetua;

  @NestedJsonKey(name: 'photo_wakil_ketua/data')
  final MediaModel? photoWakilKetua;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'publishedAt')
  final String publishedAt;

  const ElectionPartyAttributeModel({
    required this.noUrut,
    required this.ketua,
    this.photoKetua,
    required this.wakilKetua,
    this.photoWakilKetua,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        noUrut,
        ketua,
        photoKetua,
        wakilKetua,
        photoWakilKetua,
        createdAt,
        updatedAt,
        publishedAt,
      ];

  factory ElectionPartyAttributeModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$ElectionPartyAttributeModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `ElectionPartyAttributeModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$ElectionPartyAttributeModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `ElectionPartyAttributeModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}
