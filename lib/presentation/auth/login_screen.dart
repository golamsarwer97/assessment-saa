import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.h),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 4.h),
              Obx(() => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      child: Text('Login'),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  // Get the controller instance
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              TextFormField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 2.h),
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 4.h),
              Obx(() => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      child: Text('Login'),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}*/
