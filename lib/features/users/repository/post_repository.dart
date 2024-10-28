

import '../../../core/helpers/network/api_endpoints.dart';
import '../../../core/helpers/network/network_api_services.dart';

class UserRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> postApi() async {
    dynamic response = await _apiService.getApi(ApiEndPoints.posts);
    return response;
  }
}