// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kegiatan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KegiatanListModel _$KegiatanListModelFromJson(Map<String, dynamic> json) =>
    KegiatanListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => KegiatanModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KegiatanListModelToJson(KegiatanListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

KegiatanModel _$KegiatanModelFromJson(Map<String, dynamic> json) =>
    KegiatanModel(
      id: (json['id'] as num).toInt(),
      attributes: KegiatanAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KegiatanModelToJson(KegiatanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

KegiatanAttributeModel _$KegiatanAttributeModelFromJson(
        Map<String, dynamic> json) =>
    KegiatanAttributeModel(
      user: nestedReader(json, 'users_permissions_user/data') == null
          ? null
          : UserModel.fromJson(nestedReader(json, 'users_permissions_user/data')
              as Map<String, dynamic>),
      kategoriKegiatan: nestedReader(json, 'kategori_kegiatan/data') == null
          ? null
          : KategoriKegiatanModel.fromJson(
              nestedReader(json, 'kategori_kegiatan/data')
                  as Map<String, dynamic>),
      documentStatus: nestedReader(json, 'document_status/data') == null
          ? null
          : DocumentStatusModel.fromJson(
              nestedReader(json, 'document_status/data')
                  as Map<String, dynamic>),
      kerjaBakti: nestedReader(json, 'kerja_bakti/data') == null
          ? null
          : KerjaBaktiModel.fromJson(
              nestedReader(json, 'kerja_bakti/data') as Map<String, dynamic>),
      election: nestedReader(json, 'election/data') == null
          ? null
          : ElectionModel.fromJson(
              nestedReader(json, 'election/data') as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String?,
      startDate: json['start_date'] as String,
      finishDate: json['finish_date'] as String,
      rejectDescription: json['reject_description'] as String?,
      attachment: nestedReader(json, 'attachment/data') == null
          ? null
          : MediaModel.fromJson(
              nestedReader(json, 'attachment/data') as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$KegiatanAttributeModelToJson(
        KegiatanAttributeModel instance) =>
    <String, dynamic>{
      'users_permissions_user/data': instance.user?.toJson(),
      'kategori_kegiatan/data': instance.kategoriKegiatan?.toJson(),
      'document_status/data': instance.documentStatus?.toJson(),
      'kerja_bakti/data': instance.kerjaBakti?.toJson(),
      'election/data': instance.election?.toJson(),
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate,
      'finish_date': instance.finishDate,
      'reject_description': instance.rejectDescription,
      'attachment/data': instance.attachment?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
