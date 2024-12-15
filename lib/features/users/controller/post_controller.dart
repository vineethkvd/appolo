import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  //calender
  DateTime selected = DateTime.now();
  DateTime initial = DateTime(2000);
  DateTime last = DateTime(2025);

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



  Future<void> dataPosts() async {
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
  Future<void> fetchCurrentDate({required BuildContext context}) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // Header color set to blue
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.black, // Text color on the surface (dates)
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // Confirm button color
              ),
            ),
            dialogBackgroundColor: Colors.white,
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0), // Rounded corners
              ),
              elevation: 10, // Adds shadow effect
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      selected = date;
      notifyListeners();
    }
  }

}
