// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeModel _$MeModelFromJson(Map<String, dynamic> json) => MeModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      provider: json['provider'] as String,
      confirmed: json['confirmed'] as bool,
      blocked: json['blocked'] as bool,
      detail: json['user_detail'] == null
          ? null
          : MeDetailModel.fromJson(json['user_detail'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$MeModelToJson(MeModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'provider': instance.provider,
      'confirmed': instance.confirmed,
      'blocked': instance.blocked,
      'user_detail': instance.detail?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

MeDetailModel _$MeDetailModelFromJson(Map<String, dynamic> json) =>
    MeDetailModel(
      id: (json['id'] as num).toInt(),
      fullname: json['fullname'] as String,
      jenisKelamin: json['jenis_kelamin'] as String,
      rw: json['rw'] as String,
      rt: json['rt'] as String,
      alamat: json['alamat'] as String,
      domisili: json['domisili'] as String,
      photo: json['photo'] == null
          ? null
          : MeMediaModel.fromJson(json['photo'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$MeDetailModelToJson(MeDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullname': instance.fullname,
      'jenis_kelamin': instance.jenisKelamin,
      'rw': instance.rw,
      'rt': instance.rt,
      'alamat': instance.alamat,
      'domisili': instance.domisili,
      'photo': instance.photo?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'publishedAt': instance.publishedAt,
    };

MeMediaModel _$MeMediaModelFromJson(Map<String, dynamic> json) => MeMediaModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      hash: json['hash'] as String,
      ext: json['ext'] as String,
      mime: json['mime'] as String,
      size: (json['size'] as num).toDouble(),
      url: json['url'] as String,
      provider: json['provider'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$MeMediaModelToJson(MeMediaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hash': instance.hash,
      'ext': instance.ext,
      'mime': instance.mime,
      'size': instance.size,
      'url': instance.url,
      'provider': instance.provider,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
