// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jenis_surat_pengajuan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JenisSuratPengajuanListModel _$JenisSuratPengajuanListModelFromJson(
        Map<String, dynamic> json) =>
    JenisSuratPengajuanListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) =>
              JenisSuratPengajuanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JenisSuratPengajuanListModelToJson(
        JenisSuratPengajuanListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

JenisSuratPengajuanModel _$JenisSuratPengajuanModelFromJson(
        Map<String, dynamic> json) =>
    JenisSuratPengajuanModel(
      id: (json['id'] as num).toInt(),
      attributes: JenisSuratPengajuanAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JenisSuratPengajuanModelToJson(
        JenisSuratPengajuanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

JenisSuratPengajuanAttributeModel _$JenisSuratPengajuanAttributeModelFromJson(
        Map<String, dynamic> json) =>
    JenisSuratPengajuanAttributeModel(
      jenis: json['jenis'] as String,
      label: json['label'] as String,
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$JenisSuratPengajuanAttributeModelToJson(
        JenisSuratPengajuanAttributeModel instance) =>
    <String, dynamic>{
      'jenis': instance.jenis,
      'label': instance.label,
      'description': instance.description,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
