// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.birth_date,
    required this.image_url,
    required this.full_name,
    required this.points,
    required this.email,
  });

  final String id;
  final DateTime? birth_date;
  final String? image_url;
  final String? full_name;
  final int points;
  final String email;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        birth_date,
        image_url,
        full_name,
        points,
        email,
      ];
}
