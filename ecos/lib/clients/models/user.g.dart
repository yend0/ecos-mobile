// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      imageUrl: json['image_url'] as String?,
      points: (json['points'] as num).toInt(),
      email: json['email'] as String,
      emailVerified: json['email_verified'] as bool?,
      accuralHistories: (json['accural_histories'] as List<dynamic>?)
          ?.map((e) => AccuralHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
      'image_url': instance.imageUrl,
      'points': instance.points,
      'email_verified': instance.emailVerified,
      'accural_histories': instance.accuralHistories,
    };
