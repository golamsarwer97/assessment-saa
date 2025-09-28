import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  LoginController(this.loginUseCase);

  void login() async {
    isLoading.value = true;

    final result = loginUseCase.execute(
      emailController.text,
      passwordController.text,
    );

    result.fold(
      (failure) {
        Get.snackbar(
          'Error',
          failure.message,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      (success) {
        Get.snackbar(
          'Success',
          'Login successful!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offNamed('/products');
      },
    );

    isLoading.value = false;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
