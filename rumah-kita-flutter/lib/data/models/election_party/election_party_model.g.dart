// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'election_party_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ElectionPartyListModel _$ElectionPartyListModelFromJson(
        Map<String, dynamic> json) =>
    ElectionPartyListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ElectionPartyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElectionPartyListModelToJson(
        ElectionPartyListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

ElectionPartyModel _$ElectionPartyModelFromJson(Map<String, dynamic> json) =>
    ElectionPartyModel(
      id: (json['id'] as num).toInt(),
      attributes: ElectionPartyAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ElectionPartyModelToJson(ElectionPartyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

ElectionPartyAttributeModel _$ElectionPartyAttributeModelFromJson(
        Map<String, dynamic> json) =>
    ElectionPartyAttributeModel(
      noUrut: (json['no_urut'] as num).toInt(),
      ketua: json['ketua'] as String,
      photoKetua: nestedReader(json, 'photo_ketua/data') == null
          ? null
          : MediaModel.fromJson(
              nestedReader(json, 'photo_ketua/data') as Map<String, dynamic>),
      wakilKetua: json['wakil_ketua'] as String,
      photoWakilKetua: nestedReader(json, 'photo_wakil_ketua/data') == null
          ? null
          : MediaModel.fromJson(nestedReader(json, 'photo_wakil_ketua/data')
              as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$ElectionPartyAttributeModelToJson(
        ElectionPartyAttributeModel instance) =>
    <String, dynamic>{
      'no_urut': instance.noUrut,
      'ketua': instance.ketua,
      'photo_ketua/data': instance.photoKetua?.toJson(),
      'wakil_ketua': instance.wakilKetua,
      'photo_wakil_ketua/data': instance.photoWakilKetua?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
