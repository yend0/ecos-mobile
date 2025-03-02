// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo extends Equatable {
  const UserInfo({
    required this.sub,
    required this.email_verified,
    required this.email,
    required this.preferred_username,
  });

  final String sub;
  final bool email_verified;
  final String preferred_username;
  final String email;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  List<Object> get props => [
        sub,
        email_verified,
        email,
        preferred_username,
      ];
}
