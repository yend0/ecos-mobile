import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:ecos/clients/clients.dart';

part 'auth_client.g.dart';

@RestApi(baseUrl: '')
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  factory AuthClient.create({String? ssoUrl}) {
    final dio = Dio();
    if (ssoUrl != null) {
      return AuthClient(dio, baseUrl: ssoUrl);
    }
    return AuthClient(dio);
  }

  @FormUrlEncoded()
  @POST('/realms/ecos/protocol/openid-connect/token')
  Future<Token> login({
    @Field('client_id') required String clientId,
    @Field('grant_type') required String grantType,
    @Field('username') required String username,
    @Field('password') required String password,
  });

  @FormUrlEncoded()
  @POST('/realms/ecos/protocol/openid-connect/logout')
  Future<void> logout({
    @Field('client_id') required String clientId,
    @Field('refresh_token') required String refreshToken,
  });

  @FormUrlEncoded()
  @POST('/realms/ecos/protocol/openid-connect/token')
  Future<Token> refresh({
    @Field('client_id') required String clientId,
    @Field('grant_type') required String grantType,
    @Field('refresh_token') required String refreshToken,
  });

  @GET('/realms/ecos/protocol/openid-connect/userinfo')
  Future<UserInfo> userInfo({
    @Header('Authorization') required String token,
  });
}
