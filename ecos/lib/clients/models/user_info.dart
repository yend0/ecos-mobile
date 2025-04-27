import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo extends Equatable {
  const UserInfo({
    required this.sub,
    required this.emailVerified,
    required this.email,
    required this.preferredUsername,
  });

  @JsonKey(name: 'sub')
  final String sub;
  @JsonKey(name: 'email_verified')
  final bool emailVerified;
  @JsonKey(name: 'preferred_username')
  final String preferredUsername;
  @JsonKey(name: 'email')
  final String email;

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);

  @override
  List<Object> get props => [
        sub,
        emailVerified,
        email,
        preferredUsername,
      ];
}
