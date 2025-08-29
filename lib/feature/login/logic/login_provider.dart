import 'package:demo/core/networking/dio_factory.dart';
import 'package:demo/feature/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/storage/local_storage.dart';

class LoginProvider extends ChangeNotifier {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      try {
        final response = await DioFactory.postData(
          ApiConstants.login,
          data: {
            'username': usernameController.text,
            'password': passwordController.text,
          },

        );

        print("Response: ${response.data}");

        final token = response.data['meta']['token'].toString();
        final user_id = int.parse(response.data['data']['user_id'].toString());

        await LocalStorage.setString('token', token);
        await LocalStorage.setInt('user_id', user_id);


        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );


      } catch (e) {
        print("Login Error: $e");
        Fluttertoast.showToast(msg: 'incorrect');
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }
}
