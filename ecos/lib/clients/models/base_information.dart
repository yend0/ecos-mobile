import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_information.g.dart';

@JsonSerializable()
class BaseInformation extends Equatable {
  const BaseInformation({
    required this.status,
    required this.message,
  });

  @JsonKey(name: 'status')
  final String status;
  @JsonKey(name: 'message')
  final String message;

  factory BaseInformation.fromJson(Map<String, dynamic> json) =>
      _$BaseInformationFromJson(json);

  Map<String, dynamic> toJson() => _$BaseInformationToJson(this);

  @override
  List<Object> get props => [
        status,
        message,
      ];
}
