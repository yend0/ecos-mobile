import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:ecos/clients/clients.dart';

part 'waste_client.g.dart';

@RestApi(baseUrl: '')
abstract class WasteClient {
  factory WasteClient(Dio dio, {String baseUrl}) = _WasteClient;

  factory WasteClient.create({String? apiUrl}) {
    final dio = Dio();
    if (apiUrl != null) {
      return WasteClient(dio, baseUrl: apiUrl);
    }
    return WasteClient(dio);
  }

  @GET('/wastes')
  Future<List<Waste>> getWastesInformation({
    @Header('Accept-Language') String language = 'ru',
  });
}
