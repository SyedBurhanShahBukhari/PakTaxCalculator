import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Google sign-in
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: "674833002497-5tv8hb9bq4p4o62p6m5r4ntebviko7vi.apps.googleusercontent.com", // Add your Client ID here
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  // Facebook sign-in
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the Facebook sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // Get the Facebook OAuth credential using tokenString
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken!.tokenString);

      // Sign in to Firebase with the Facebook credential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } else {
      // Handle different errors
      throw FirebaseAuthException(
        code: 'ERROR_FACEBOOK_LOGIN_FAILED',
        message: result.message,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF7F7F7),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Container(
          margin: EdgeInsets.only(left: 15, top: 10, bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.green),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              '',
              style: TextStyle(
                fontFamily: 'Overpass',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xFFF7F7F7),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  "Sign Up With",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton("assets/apple.png", () {
                      // Add Apple sign-in here if needed
                      print("Apple sign-in");
                    }),
                    SizedBox(width: 20),
                    _socialButton("assets/google.png", () async {
                      try {
                        await signInWithGoogle();
                        print("Google sign-in successful");
                      } catch (e) {
                        print("Google sign-in failed: $e");
                      }
                    }),
                    SizedBox(width: 20),
                    _socialButton("assets/facebook.png", () async {
                      try {
                        await signInWithFacebook();
                        print("Facebook sign-in successful");
                      } catch (e) {
                        print("Facebook sign-in failed: $e");
                      }
                    }),
                  ],
                ),
                SizedBox(height: 20),
                // Rest of the form fields
                _inputField("Full Name", Icons.person, false, _nameController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                }),
                SizedBox(height: 30),
                _inputField("Email address", Icons.email, false, _emailController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                }),
                SizedBox(height: 30),
                _inputField("Password", Icons.lock, true, _passwordController, (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                }),
                SizedBox(height: 30),
                _inputField("Confirm Password", Icons.lock, true, _confirmPasswordController, (value) {
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                }),
                SizedBox(height: 30),
                // Create Account button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Create user with Firebase Authentication
                        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        // Get the user's UID
                        String uid = userCredential.user!.uid;

                        // Store user data in Firestore
                        await FirebaseFirestore.instance.collection('users').doc(uid).set({
                          'full_name': _nameController.text,
                          'email': _emailController.text,
                          'created_at': DateTime.now(), // Optional: add created timestamp
                        });

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Signup successful, data saved!"))
                        );

                        // Navigate to the home page or welcome page after successful signup
                        Navigator.pushReplacementNamed(context, '/welcome'); // Replace with your desired route

                      } on FirebaseAuthException catch (e) {
                        // Handle authentication errors
                        String errorMessage;
                        if (e.code == 'weak-password') {
                          errorMessage = 'The password is too weak.';
                        } else if (e.code == 'email-already-in-use') {
                          errorMessage = 'An account already exists for that email.';
                        } else {
                          errorMessage = 'Signup failed: ${e.message}';
                        }

                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(errorMessage))
                        );
                      } catch (e) {
                        // Handle Firestore errors or any other issues
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error saving data: $e"))
                        );
                      }
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
                    'Create Account',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(color: Colors.green),
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.pushNamed(context, '/LoginPage');
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

  Widget _socialButton(String assetName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: Image.asset(assetName, width: 40, height: 40),
      ),
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
}
