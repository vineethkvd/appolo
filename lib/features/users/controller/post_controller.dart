import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/post_model.dart';
import '../repository/post_repository.dart';

class PostController extends ChangeNotifier{
  final _api = UserRepository();
  bool isLoading = false;
bool isActive=false;
  void toggleActive() {
    isActive = !isActive;
    notifyListeners();
  }
  //post api
  var postModel = PostModel();
  var postList = <PostModel>[];
  var selectedStateId = '';
  var selectedStateName = '';
  Future<void> postApi() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _api.postApi();
      if (response != null && response['status'] == 200) {
        final List<dynamic> responseData = response['data'];
        postList =
            responseData.map((json) => PostModel.fromJson(json)).toList();
        notifyListeners();
      } else if (response != null && response['status'] == 400) {
        postModel = PostModel.fromJson(response['data']);
        notifyListeners();
      } else {
        CustomToast.showCustomToast(message: "Unexpected error occurred");
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


}