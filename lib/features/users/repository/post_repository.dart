

import '../../../core/helpers/network/api_endpoints.dart';
import '../../../core/helpers/network/network_api_services.dart';

class UserRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> postApi(int page, int limit) async {
    final String url = '${ApiEndPoints.posts}?_page=$page&_limit=$limit';
    dynamic response = await _apiService.getApi(url);
    return response;
  }

  Future<dynamic> dataApi(int page, int limit) async {
    const String url = ApiEndPoints.posts;
    dynamic response = await _apiService.getApi(url);
    return response;
  }
}
