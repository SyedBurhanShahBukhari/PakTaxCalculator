import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Text(
                  "Login With",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Overpass',
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton("assets/apple.png"),
                    SizedBox(width: 20),
                    _socialButton("assets/google.png"),
                    SizedBox(width: 20),
                    _socialButton("assets/facebook.png"),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontFamily: 'Overpass',
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 35),
                _inputField(
                  "Email address",
                  Icons.email,
                  false,
                  emailController,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                _inputField(
                  "Password",
                  Icons.lock,
                  true,
                  passwordController,
                      (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Switch(
                      value: rememberMe,
                      onChanged: (value) {
                        setState(() {
                          rememberMe = value;
                        });
                      },
                      activeColor: Colors.green,
                    ),
                    Text(
                      'Remember me',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _loginUser(emailController.text, passwordController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Overpass',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    text: "Don’t have an account? ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Create Account",
                        style: TextStyle(color: Colors.green),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.pushNamed(context, '/createAccount');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String assetName) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Image.asset(assetName, width: 40, height: 40),
    );
  }

  Widget _inputField(String hint, IconData icon, bool isPassword, TextEditingController controller, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      cursorColor: Colors.green,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.green),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
      ),
      validator: validator,
    );
  }

  Future<void> _loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacementNamed(context, '/welcome');
      print("Login successful for user: ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login failed: ${e.message}';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during login: $e")),
      );
    }
  }
}
