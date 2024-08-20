// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surat_pengajuan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuratPengajuanListModel _$SuratPengajuanListModelFromJson(
        Map<String, dynamic> json) =>
    SuratPengajuanListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => SuratPengajuanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuratPengajuanListModelToJson(
        SuratPengajuanListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

SuratPengajuanModel _$SuratPengajuanModelFromJson(Map<String, dynamic> json) =>
    SuratPengajuanModel(
      id: (json['id'] as num).toInt(),
      attributes: SuratPengajuanAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuratPengajuanModelToJson(
        SuratPengajuanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

SuratPengajuanAttributeModel _$SuratPengajuanAttributeModelFromJson(
        Map<String, dynamic> json) =>
    SuratPengajuanAttributeModel(
      user: nestedReader(json, 'users_permissions_user/data') == null
          ? null
          : UserModel.fromJson(nestedReader(json, 'users_permissions_user/data')
              as Map<String, dynamic>),
      jenisSuratPengajuan:
          nestedReader(json, 'jenis_surat_pengajuan/data') == null
              ? null
              : JenisSuratPengajuanModel.fromJson(
                  nestedReader(json, 'jenis_surat_pengajuan/data')
                      as Map<String, dynamic>),
      documentStatus: nestedReader(json, 'document_status/data') == null
          ? null
          : DocumentStatusModel.fromJson(
              nestedReader(json, 'document_status/data')
                  as Map<String, dynamic>),
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      alamat: json['alamat'] as String,
      rejectDescription: json['reject_description'] as String?,
      documents: (nestedReader(json, 'documents/data') as List<dynamic>?)
          ?.map((e) => MediaModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$SuratPengajuanAttributeModelToJson(
        SuratPengajuanAttributeModel instance) =>
    <String, dynamic>{
      'users_permissions_user/data': instance.user?.toJson(),
      'jenis_surat_pengajuan/data': instance.jenisSuratPengajuan?.toJson(),
      'document_status/data': instance.documentStatus?.toJson(),
      'fullname': instance.fullname,
      'email': instance.email,
      'alamat': instance.alamat,
      'reject_description': instance.rejectDescription,
      'documents/data': instance.documents?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
