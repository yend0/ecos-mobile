import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'waste_translation.g.dart';

@JsonSerializable()
class WasteTranslation extends Equatable {
  const WasteTranslation({
    required this.id,
    required this.description,
    required this.name,
  });

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'name')
  final String name;

  factory WasteTranslation.fromJson(Map<String, dynamic> json) =>
      _$WasteTranslationFromJson(json);

  Map<String, dynamic> toJson() => _$WasteTranslationToJson(this);

  @override
  List<Object> get props => [
        id,
        description,
        name,
      ];
}
