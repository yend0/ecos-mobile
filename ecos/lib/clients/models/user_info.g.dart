// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) => UserInfo(
      sub: json['sub'] as String,
      emailVerified: json['email_verified'] as bool,
      email: json['email'] as String,
      preferredUsername: json['preferred_username'] as String,
    );

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'sub': instance.sub,
      'email_verified': instance.emailVerified,
      'preferred_username': instance.preferredUsername,
      'email': instance.email,
    };
