// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      sub: json['sub'] as String,
      email_verified: json['email_verified'] as bool,
      email: json['email'] as String,
      preferred_username: json['preferred_username'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'sub': instance.sub,
      'email_verified': instance.email_verified,
      'preferred_username': instance.preferred_username,
      'email': instance.email,
    };
