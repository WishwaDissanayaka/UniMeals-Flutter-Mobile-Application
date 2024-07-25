// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_category_provider.dart';
import '../../firebase_auth_implementation/firebase_auth_services.dart';

import 'package:passdata/common_components.dart/custom_app_bar.dart';
import 'package:passdata/splash_login_auth/user_auth/presentation/loginpages/sign_up_page.dart';
import 'package:passdata/splash_login_auth/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:passdata/global/common/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userCategory = context.watch<UserCategoryProvider>().userCategory;
    final categoryMessage =
        "You are chosen to Login as a ${userCategory ?? 'unknown'}";

    return Scaffold(
      appBar: const CustomAppBar01(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                categoryMessage,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/loginasa');
                },
                child: const Text(
                  "Change User Category",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 0),
              const Text(
                "or",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                "Provide Email and Password to Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  _signIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigning
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
             
             
              // GestureDetector(
              //   onTap: () {
              //     _signInWithGoogle();
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     height: 45,
              //     decoration: BoxDecoration(
              //       color: Colors.red,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Center(
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: const [
              //           Icon(
              //             FontAwesomeIcons.google,
              //             color: Colors.white,
              //           ),
              //           SizedBox(width: 5),
              //           Text(
              //             "Sign in with Google",
              //             style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),


              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
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
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {
      showToast(message: "User is successfully signed in");
      _storeUserData(user, email, password);
      // ignore: use_build_context_synchronously
      _navigateToUserCategoryScreen(context);
    } else {
      showToast(message: "Some error occurred");
    }
  }

  // ignore: unused_element
  _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          showToast(message: "User is successfully signed in");
          _storeUserData(user, user.email!, null);
          _navigateToUserCategoryScreen(context);
        }
      }
    } catch (e) {
      showToast(message: "Some error occurred: $e");
    }
  }

  void _storeUserData(User user, String email, String? password) {
    final userCategory = context.read<UserCategoryProvider>().userCategory;

    _firestore.collection('users').doc(user.uid).set({
      'userName': user.displayName ?? 'Unknown',
      'userEmail': email,
      'userCategory': userCategory,
      'userPassword': password ?? 'Signed in with Google',
      'timestamp': Timestamp.now(),
    });
  }

  void _navigateToUserCategoryScreen(BuildContext context) {
    final userCategory = context.read<UserCategoryProvider>().userCategory;
    switch (userCategory) {
      case 'agent':
        Navigator.pushNamed(context, '/agent_login');
        break;
      case 'seller':
        Navigator.pushNamed(context, '/seller_login');
        break;
      case 'customer':
        Navigator.pushNamed(context, '/customer_login');
        break;
      default:
        Navigator.pushNamed(context, '/loginasa');
    }
  }
}
