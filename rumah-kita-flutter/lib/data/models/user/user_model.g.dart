// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserListModel _$UserListModelFromJson(Map<String, dynamic> json) =>
    UserListModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      meta: json['meta'] == null
          ? null
          : MetadataModel.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserListModelToJson(UserListModel instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'meta': instance.meta?.toJson(),
    };

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num).toInt(),
      attributes: UserAttributeModel.fromJson(
          json['attributes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'attributes': instance.attributes.toJson(),
    };

UserAttributeModel _$UserAttributeModelFromJson(Map<String, dynamic> json) =>
    UserAttributeModel(
      username: json['username'] as String,
      email: json['email'] as String,
      provider: json['provider'] as String,
      confirmed: json['confirmed'] as bool,
      blocked: json['blocked'] as bool,
      detail: nestedReader(json, 'user_detail/data') == null
          ? null
          : UserDetailModel.fromJson(
              nestedReader(json, 'user_detail/data') as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$UserAttributeModelToJson(UserAttributeModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'provider': instance.provider,
      'confirmed': instance.confirmed,
      'blocked': instance.blocked,
      'user_detail/data': instance.detail?.toJson(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
