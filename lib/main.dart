import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'package:passdata/splash_login_auth/app/splash_screen/splash_screen.dart';
import 'package:passdata/splash_login_auth/user_auth/presentation/loginpages/login_page.dart';
import 'package:passdata/splash_login_auth/user_auth/presentation/loginpages/sign_up_page.dart';
import 'package:passdata/content_screens/login_as_a.dart';
import 'package:passdata/content_screens/agent_screens/agent_dashboard.dart';
import 'package:passdata/content_screens/customer_screens/customer_dashboard.dart';
import 'package:passdata/content_screens/seller_screens/seller_dashboard.dart';
import 'package:passdata/content_screens/agent_screens/admin_login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC1AYxwL7fOCsuJkkgFMimtuFLFizinfcs",
        appId: "1:77328628230:android:8269d3bffe81d332926187",
        messagingSenderId: "77328628230",
        projectId: "passda-2559a",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => SplashScreen(
              // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
              child: LoginPage(),
            ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => LoginScreen(),
        '/loginasa': (context) => LoginScreen(),
        '/agent_login': (context) => const AdminLogin(),
        '/seller_login': (context) => const SellerDashboardScreen(),
        '/customer_login': (context) => const CustomerDashboardScreen(),
      },
    );
  }
}
