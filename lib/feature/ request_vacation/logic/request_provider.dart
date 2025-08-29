import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/networking/api_constants.dart';
import '../../../core/networking/dio_factory.dart';
import '../../../core/storage/local_storage.dart';

class RequestProvider extends ChangeNotifier {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final reasonController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> sendRequest(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();

    final int user_id = await LocalStorage.getInt('user_id') ?? 0;
    final String? token = await LocalStorage.getString('token');

    final Map<String, dynamic> data = {
      "starts_at": startDateController.text,
      "ends_at": endDateController.text,
      "reason": reasonController.text,
      "user_id": user_id.toString(),
    };

    print("=== Sending Vacation Request ===");
    print("Data: $data");
    print("Token: $token");
    print("===============================");

    try {
      Response response = await DioFactory.dio.post(
        ApiConstants.requestVacations,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      print("Server Response: ${response.data}");

      if (response.data['success'] == true) {
        Fluttertoast.showToast(
            msg: response.data['meta']['message'] ?? 'Request sent successfully');
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: response.data['meta']['message'] ?? 'Failed to send request');
      }
    } on DioException catch (e) {
      print("Request Error: ${e.response?.statusCode}");
      print("Full Error: ${e.response?.data}");
      Fluttertoast.showToast(
          msg: 'Server Error: ${e.response?.data ?? e.message}');
    } catch (e) {
      print("Unexpected Error: $e");
      Fluttertoast.showToast(msg: 'Unexpected error occurred');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
