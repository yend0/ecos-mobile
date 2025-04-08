// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseInformation _$BaseInformationFromJson(Map<String, dynamic> json) =>
    BaseInformation(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$BaseInformationToJson(BaseInformation instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
