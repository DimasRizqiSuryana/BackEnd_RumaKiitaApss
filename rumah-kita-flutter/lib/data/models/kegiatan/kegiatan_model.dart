import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../utils/logger.dart';
import '../../../utils/extensions.dart';
import '../document_status/document_status_model.dart';
import '../kategori_kegiatan/kategori_kegiatan_model.dart';
import '../media/media_model.dart';
import '../user/user_model.dart';
import '../utils.dart';

part 'kegiatan_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class KegiatanListModel extends Equatable {
  final List<KegiatanModel> data;
  final MetadataModel? meta;

  const KegiatanListModel({
    required this.data,
    this.meta,
  });

  @override
  List<Object?> get props => [
        data,
        meta,
      ];

  factory KegiatanListModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$KegiatanListModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `KegiatanListModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$KegiatanListModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `KegiatanListModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class KegiatanModel extends Equatable {
  final int id;
  final KegiatanAttributeModel attributes;

  const KegiatanModel({
    required this.id,
    required this.attributes,
  });

  @override
  List<Object?> get props => [
        id,
        attributes,
      ];

  factory KegiatanModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$KegiatanModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message: 'Failed to Parse `Map<String, dynamic>` into `KegiatanModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$KegiatanModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message: 'Failed to Parse `KegiatanModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class KegiatanAttributeModel extends Equatable {
  @NestedJsonKey(name: 'users_permissions_user/data')
  final UserModel? user;

  @NestedJsonKey(name: 'kategori_kegiatan/data')
  final KategoriKegiatanModel? kategoriKegiatan;

  @NestedJsonKey(name: 'document_status/data')
  final DocumentStatusModel? documentStatus;

  final String title;
  final String? description;
  final String startDate;
  final String finishDate;
  final String? rejectDescription;

  @NestedJsonKey(name: 'attachment/data')
  final MediaModel? attachment;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'publishedAt')
  final String publishedAt;

  const KegiatanAttributeModel({
    this.user,
    this.kategoriKegiatan,
    this.documentStatus,
    required this.title,
    this.description,
    required this.startDate,
    required this.finishDate,
    this.rejectDescription,
    this.attachment,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        user,
        kategoriKegiatan,
        documentStatus,
        title,
        description,
        startDate,
        finishDate,
        rejectDescription,
        attachment,
        createdAt,
        updatedAt,
        publishedAt,
      ];

  factory KegiatanAttributeModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$KegiatanAttributeModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `KegiatanAttributeModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$KegiatanAttributeModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `KegiatanAttributeModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}
