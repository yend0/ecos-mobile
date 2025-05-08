import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'accural_history.g.dart';

@JsonSerializable()
class AccuralHistory extends Equatable {
  const AccuralHistory({
    required this.id,
    required this.points,
    required this.reward,
    required this.created,
  });

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'points')
  final int points;
  @JsonKey(name: 'reward')
  final String reward;
  @JsonKey(name: 'created_at')
  final DateTime created;

  factory AccuralHistory.fromJson(Map<String, dynamic> json) =>
      _$AccuralHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$AccuralHistoryToJson(this);

  @override
  List<Object> get props => [
        id,
        points,
        reward,
        created,
      ];
}
