import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart/views/login/login_screen.dart';

import '../../providers/api_authentication_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiAuthenticationProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 560,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 50),
            child: Text(
              "Create Your ShopSmart Account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ))),
          Padding(
            padding: const EdgeInsets.only(top: 120.0, left: 15, right: 15),
            child: Container(
              height: 620,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(-3, -3),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(4, 6),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Full Name
                      TextFormField(
                        controller: provider.userNameController,
                          keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your full name";
                          }
                          return null;
                        },
                        cursorColor: Colors.orange,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Full Name',
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.orange),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Email
                      TextFormField(
                        controller: provider.emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          if (!value.contains("@gmail.com")) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.orange,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.orange),
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Password
                      TextFormField(
                        controller: provider.passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                        }
                          return null;},
                        obscureText: true,
                        cursorColor: Colors.orange,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.orange),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Confirm Password
                      TextFormField(
                        controller: provider.confirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your confirm password";
                          }
                          if (value != provider.passwordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        obscureText: true,
                        cursorColor: Colors.orange,
                        style: const TextStyle(color: Colors.black),
                        decoration:  InputDecoration(
                          hintText: 'Confirm Password',
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.orange),
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: IconButton(onPressed: () {
                              provider.visiblePassword = !provider.visiblePassword;
                              provider.notifyListeners();
                          }, icon:provider.visiblePassword ? Icon(Icons.remove_red_eye): Icon(Icons.visibility_off)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            provider.userSignUp(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.orange),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),)); // back to login
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
