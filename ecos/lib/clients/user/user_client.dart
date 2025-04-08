import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:ecos/clients/clients.dart';

part 'user_client.g.dart';

@RestApi(baseUrl: '')
abstract class UserClient {
  factory UserClient(Dio dio, {String baseUrl}) = _UserClient;

  factory UserClient.create({String? apiUrl}) {
    final dio = Dio();
    if (apiUrl != null) {
      return UserClient(dio, baseUrl: apiUrl);
    }
    return UserClient(dio);
  }

  @FormUrlEncoded()
  @POST('/users/sign-up')
  Future<BaseInformation> register({
    @Header('Content-Type') String type = 'application/json',
    @Field('email') required String email,
    @Field('password') required String password,
  });

  @MultiPart()
  @PATCH('/users/profile')
  Future<User> updateAccountInformation({
    @Header('Authorization') required String token,
    @Part() List<MultipartFile>? files,
    @Part() User? data,
  });

  @GET('/users/profile')
  Future<User> getAccountInformation({
    @Header('Authorization') required String token,
  });
}
