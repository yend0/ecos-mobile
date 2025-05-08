// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accural_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccuralHistory _$AccuralHistoryFromJson(Map<String, dynamic> json) =>
    AccuralHistory(
      id: json['id'] as String,
      points: (json['points'] as num).toInt(),
      reward: json['reward'] as String,
      created: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AccuralHistoryToJson(AccuralHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'points': instance.points,
      'reward': instance.reward,
      'created_at': instance.created.toIso8601String(),
    };
