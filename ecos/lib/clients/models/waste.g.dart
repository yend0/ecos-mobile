// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waste.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Waste _$WasteFromJson(Map<String, dynamic> json) => Waste(
      id: json['id'] as String,
      abbreviatedName: json['abbreviated_name'] as String,
      imageUrl: json['image_url'] as String,
      wasteTranslations: (json['waste_translations'] as List<dynamic>)
          .map((e) => WasteTranslation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WasteToJson(Waste instance) => <String, dynamic>{
      'id': instance.id,
      'abbreviated_name': instance.abbreviatedName,
      'image_url': instance.imageUrl,
      'waste_translations': instance.wasteTranslations,
    };
