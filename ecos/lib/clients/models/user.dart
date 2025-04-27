import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:ecos/clients/clients.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.birthDate,
    required this.imageUrl,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.points,
    required this.email,
    this.emailVerified,
    this.accuralHistories,
  });

  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'birth_date')
  final DateTime? birthDate;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'points')
  final int points;
  @JsonKey(name: 'email_verified')
  final bool? emailVerified;

  @JsonKey(name: 'accural_histories')
  final List<AccuralHistory>? accuralHistories;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        birthDate,
        imageUrl,
        firstName,
        middleName,
        lastName,
        emailVerified,
        points,
        email,
        accuralHistories,
      ];
}
