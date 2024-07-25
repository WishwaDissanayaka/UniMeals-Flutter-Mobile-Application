// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:passdata/common_components.dart/custom_app_bar.dart';


class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    Future.delayed(
      Duration(seconds: 4),(){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.child!), (route) => false);
    }
    );
    super.initState();
  }


  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar01(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Image.asset(
                'assets/dsBuffer.png',
                width: double.infinity,
              ),
            ),
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/loginasa');
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  side: const BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Color.fromARGB(193, 255, 255, 255),
                ),
                child: const Text(
                  'WELCOME TO UNIMEAL',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600, // Updated font weight
                    fontFamily: 'Georgia', // Updated font family
                    color: Color.fromARGB(255, 0, 30, 255),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
