import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/shared/component/widgets/custom_toast.dart';
import '../model/post_model.dart';
import '../repository/post_repository.dart';

class PostController extends ChangeNotifier {
  final _api = UserRepository();
  bool isLoading = false;
  bool isActive = false;
  int currentPage = 1;
  final int limit = 10;

  var postModel = PostModel();
  var postList = <PostModel>[];

  Future<void> fetchPosts() async {
    try {
      isLoading = true;
      notifyListeners();
      final response = await _api.postApi(currentPage, limit);
      if (response != null && response['status'] == 200) {
        final List<dynamic> responseData = response['data'];
        postList.addAll(responseData.map((json) => PostModel.fromJson(json)).toList());
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

  void nextPage() {
    currentPage++;
    fetchPosts();
  }

  void resetPagination() {
    currentPage = 1;
    postList.clear();
    fetchPosts();
  }
}
