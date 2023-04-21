import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'signup_screen.dart';
import 'forgot_password.dart';
import 'board_manager.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordFocusNode = FocusNode();
  Map<String, dynamic> userList = {};
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    getUserList();
  }

  Future<Map<String, dynamic>> getUserList() async {
    // Change this line
    final response =
        await http.get(Uri.parse('http://192.168.1.9/api/getAccount'));
    if (response.statusCode == 200) {
      setState(() {
        userList = jsonDecode(response.body);
      });
      return userList;
    } else {
      throw Exception('Failed to load user list');
    }

    // Add a return statement here to avoid the warning
    return {};
  }

  bool validateUser(String email, String password) {
    // List<dynamic> users = jsonDecode(userList['Data']);

    // for (var user in users) {
    //   if (email == user['Username'] && password == user['Password']) {
    return true;
    //   }
    // }

    // return false;
  }

  void handleLogin() {
    String email = emailController.text;
    String password = passwordController.text;
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        validateUser(email, password)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Board(0),
        ),
      );
    } else {
      // Show error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Credentials'),
          content: Text('The username or password you entered is incorrect.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                passwordController.clear(); // clear password input
                passwordFocusNode
                    .requestFocus(); // move focus back to password field
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 50),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              obscureText: !isPasswordVisible,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: handleLogin,
                child: Text('Log In'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return Colors.black;
                      return Colors.blue;
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.black.withOpacity(0.04);
                        return Colors.redAccent; // default value
                      },
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered))
                          return Colors.black.withOpacity(0.04);
                        return Colors.redAccent; // default value
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
