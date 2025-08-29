import 'package:flutter/cupertino.dart';

import '../../../core/networking/api_constants.dart';
import '../../../core/networking/dio_factory.dart';
import '../../../core/storage/local_storage.dart';

class ProfileProvider extends ChangeNotifier{
  Map<String, dynamic>? profileData;
  bool isLoading = false;
  Future<void> loadProfile() async {
    try {
      isLoading = true;
      notifyListeners();
      final token = LocalStorage.getString('token');
      final userId = LocalStorage.getInt('user_id');

      final response = await DioFactory.getData(
        "${ApiConstants.profile}$userId",
        token: token,
      );
      profileData = response.data['data'];
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Profile Error: $e");
    }
  }
}