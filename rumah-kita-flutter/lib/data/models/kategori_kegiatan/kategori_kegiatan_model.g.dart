// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kategori_kegiatan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KategoriKegiatanListModel _$KategoriKegiatanListModelFromJson(
        Map<String, dynamic> json) =>
    KategoriKegiatanListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => KategoriKegiatanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KategoriKegiatanListModelToJson(
        KategoriKegiatanListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

KategoriKegiatanModel _$KategoriKegiatanModelFromJson(
        Map<String, dynamic> json) =>
    KategoriKegiatanModel(
      id: (json['id'] as num).toInt(),
      attributes: KategoriKegiatanAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KategoriKegiatanModelToJson(
        KategoriKegiatanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

KategoriKegiatanAttributeModel _$KategoriKegiatanAttributeModelFromJson(
        Map<String, dynamic> json) =>
    KategoriKegiatanAttributeModel(
      kategori: json['kategori'] as String,
      label: json['label'] as String,
      description: json['description'] as String?,
      cover: nestedReader(json, 'cover/data') == null
          ? null
          : MediaModel.fromJson(
              nestedReader(json, 'cover/data') as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$KategoriKegiatanAttributeModelToJson(
        KategoriKegiatanAttributeModel instance) =>
    <String, dynamic>{
      'kategori': instance.kategori,
      'label': instance.label,
      'description': instance.description,
      'cover/data': instance.cover?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
