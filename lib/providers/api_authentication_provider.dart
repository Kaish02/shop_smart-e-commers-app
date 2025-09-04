import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_servics.dart';
import '../views/deasboard/deashboard_screen.dart';
import '../views/home/home_screen.dart';
import '../views/login/login_screen.dart';

class ApiAuthenticationProvider with ChangeNotifier {
  bool visiblePassword = false;

  void togglePasswordVisibility() {
    visiblePassword = !visiblePassword;
    notifyListeners();
  }

  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  void showToast(String message, {Color bgColor = Colors.black}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> userSignUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var data = {
        "username": userNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      userNameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();

        var response = await ApiServics.userCreateAccount(data);
        if (response != null) {
          var sharePrefrencs=await SharedPreferences.getInstance();
          sharePrefrencs.setString("token", response.toString());

          showToast("Signup Successful!", bgColor: Colors.green);
          Navigator.pushReplacement(
            context,
              MaterialPageRoute(builder: (context) => LoginScreen()),);
        } else {
          showToast("Signup Failed! Please try again.", bgColor: Colors.red);
        }
    }
  }

  userLogIn(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var data = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };
      emailController.clear();
      passwordController.clear();

        var response = await ApiServics.userLogIn(data);
        if (response != null) {
          var sharePrefrencs=await SharedPreferences.getInstance();
          sharePrefrencs.setString("token", response.toString());
          showToast("Login Successful!", bgColor: Colors.green);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                 DeashboardScreen()),);
        }
        else {
          showToast("Login Failed! Please try again.", bgColor: Colors.red);
        }
      }
  }
}
