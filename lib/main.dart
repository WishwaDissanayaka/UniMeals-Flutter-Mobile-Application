import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'package:passdata/splash_login_auth/app/splash_screen/splash_screen.dart';
import 'package:passdata/splash_login_auth/user_auth/presentation/loginpages/login_page.dart';
import 'package:passdata/splash_login_auth/user_auth/presentation/loginpages/sign_up_page.dart';
import 'package:passdata/splash_login_auth/user_auth/presentation/loginpages/login_as_a.dart';
import 'package:passdata/content_screens/customer_screens/customer_dashboard.dart';
import 'package:passdata/content_screens/seller_screens/seller_dashboard.dart';
import 'package:passdata/content_screens/agent_screens/agent_dashboard.dart';
import 'package:passdata/splash_login_auth/user_auth/presentation/loginpages/user_category_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC1AYxwL7fOCsuJkkgFMimtuFLFizinfcs",
        appId: "1:77328628230:android:8269d3bffe81d332926187",
        messagingSenderId: "77328628230",
        projectId: "passda-2559a",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserCategoryProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Firebase',
        routes: {
          '/': (context) => const SplashScreen(
                // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
                child: LoginScreen(),
              ),
          '/login': (context) => const LoginPage(),
          '/signUp': (context) => const SignUpPage(),
          '/loginasa': (context) => const LoginScreen(),
          '/agent_login': (context) => const AgentDashboardScreen(),
          '/seller_login': (context) => const SellerDashboardScreen(),
          '/customer_login': (context) => const CustomerDashboardScreen(),
        },
      ),
    );
  }
}
