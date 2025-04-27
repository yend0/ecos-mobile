import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:ecos/clients/clients.dart';

part 'waste.g.dart';

@JsonSerializable()
class Waste extends Equatable {
  const Waste({
    required this.id,
    required this.abbreviatedName,
    required this.imageUrl,
    required this.wasteTranslations,
  });

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'abbreviated_name')
  final String abbreviatedName;
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @JsonKey(name: 'waste_translations')
  final List<WasteTranslation> wasteTranslations;

  factory Waste.fromJson(Map<String, dynamic> json) => _$WasteFromJson(json);

  Map<String, dynamic> toJson() => _$WasteToJson(this);

  @override
  List<Object> get props => [
        id,
        abbreviatedName,
        imageUrl,
        wasteTranslations,
      ];
}
