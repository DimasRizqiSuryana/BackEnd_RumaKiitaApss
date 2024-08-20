// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailListModel _$UserDetailListModelFromJson(Map<String, dynamic> json) =>
    UserDetailListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDetailListModelToJson(
        UserDetailListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) =>
    UserDetailModel(
      id: (json['id'] as num).toInt(),
      attributes: UserDetailAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDetailModelToJson(UserDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

UserDetailAttributeModel _$UserDetailAttributeModelFromJson(
        Map<String, dynamic> json) =>
    UserDetailAttributeModel(
      fullname: json['fullname'] as String,
      jenisKelamin: json['jenis_kelamin'] as String,
      rw: json['rw'] as String,
      rt: json['rt'] as String,
      alamat: json['alamat'] as String,
      domisili: json['domisili'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$UserDetailAttributeModelToJson(
        UserDetailAttributeModel instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'jenis_kelamin': instance.jenisKelamin,
      'rw': instance.rw,
      'rt': instance.rt,
      'alamat': instance.alamat,
      'domisili': instance.domisili,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };
