// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      birth_date: json['birth_date'] == null
          ? null
          : DateTime.parse(json['birth_date'] as String),
      image_url: json['image_url'] as String?,
      full_name: json['full_name'] as String?,
      points: (json['points'] as num).toInt(),
      email: json['email'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'birth_date': instance.birth_date?.toIso8601String(),
      'image_url': instance.image_url,
      'full_name': instance.full_name,
      'points': instance.points,
      'email': instance.email,
    };
