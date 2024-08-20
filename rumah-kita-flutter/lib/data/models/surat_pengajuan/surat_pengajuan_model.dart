import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/base/base.dart';
import '../../../../utils/logger.dart';
import '../../../utils/extensions.dart';
import '../document_status/document_status_model.dart';
import '../jenis_surat_pengajuan/jenis_surat_pengajuan_model.dart';
import '../media/media_model.dart';
import '../user/user_model.dart';
import '../utils.dart';

part 'surat_pengajuan_model.g.dart';

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class SuratPengajuanListModel extends Equatable {
  final List<SuratPengajuanModel> data;
  final MetadataModel? meta;

  const SuratPengajuanListModel({
    required this.data,
    this.meta,
  });

  @override
  List<Object?> get props => [
        data,
        meta,
      ];

  factory SuratPengajuanListModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$SuratPengajuanListModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `SuratPengajuanListModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$SuratPengajuanListModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `SuratPengajuanListModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class SuratPengajuanModel extends Equatable {
  final int id;
  final SuratPengajuanAttributeModel attributes;

  const SuratPengajuanModel({
    required this.id,
    required this.attributes,
  });

  @override
  List<Object?> get props => [
        id,
        attributes,
      ];

  factory SuratPengajuanModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$SuratPengajuanModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `SuratPengajuanModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$SuratPengajuanModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `SuratPengajuanModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}

@JsonSerializable(
  explicitToJson: true,
  fieldRename: FieldRename.snake,
)
class SuratPengajuanAttributeModel extends Equatable {
  @NestedJsonKey(name: 'users_permissions_user/data')
  final UserModel? user;

  @NestedJsonKey(name: 'jenis_surat_pengajuan/data')
  final JenisSuratPengajuanModel? jenisSuratPengajuan;

  @NestedJsonKey(name: 'document_status/data')
  final DocumentStatusModel? documentStatus;

  final String fullname;
  final String email;
  final String alamat;
  final String? rejectDescription;

  @NestedJsonKey(name: 'documents/data')
  final List<MediaModel>? documents;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  @JsonKey(name: 'publishedAt')
  final String publishedAt;

  const SuratPengajuanAttributeModel({
    this.user,
    this.jenisSuratPengajuan,
    this.documentStatus,
    required this.fullname,
    required this.email,
    required this.alamat,
    this.rejectDescription,
    this.documents,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
        user,
        jenisSuratPengajuan,
        documentStatus,
        fullname,
        email,
        alamat,
        rejectDescription,
        documents,
        createdAt,
        updatedAt,
        publishedAt,
      ];

  factory SuratPengajuanAttributeModel.fromJson(Map<String, dynamic> json) {
    try {
      return _$SuratPengajuanAttributeModelFromJson(json);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'fromJson',
        message:
            'Failed to Parse `Map<String, dynamic>` into `SuratPengajuanAttributeModel`',
        stacktrace: stacktrace,
      );
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return _$SuratPengajuanAttributeModelToJson(this);
    } catch (e, stacktrace) {
      logger.e('DataParsingException', error: e, stackTrace: stacktrace);
      throw DataParsingException(
        operation: 'toJson',
        message:
            'Failed to Parse `SuratPengajuanAttributeModel` into `Map<String, dynamic>`',
        stacktrace: stacktrace,
      );
    }
  }
}
