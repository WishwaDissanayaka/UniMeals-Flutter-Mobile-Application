import 'package:flutter/material.dart';

class CustomAppBar01 extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const CustomAppBar01({super.key})
      : preferredSize = const Size.fromHeight(120.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 5.0, 0, 10.0), // Added top padding
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 25, 196, 33),
            Color.fromARGB(255, 71, 157, 232),
            Color.fromARGB(255, 255, 255, 255)
          ], // Gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(15.0), // Rounded corners at the bottom
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/dsBuffer.png', // Path to your image
                height: 70.0, // Adjust the height as needed
                width: 70.0, // Adjust the width as needed
              ),
            ),
            Expanded(
              child: RichText(
                textAlign: TextAlign.left,
                text: const TextSpan(
                  text: ' Uni',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30, // Updated font size
                    fontWeight: FontWeight.bold, // Updated font weight
                    fontFamily: 'Roboto', // Updated font family
                  ),
                  children: [
                    TextSpan(
                      text: 'Meals',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42, // Updated font size
                        fontWeight: FontWeight.bold, // Updated font weight
                        fontFamily: 'Roboto', // Updated font family
                      ),
                    ),
                    TextSpan(
                      text: '\n Order any Meals around You!',
                      style: TextStyle(
                        color: Color.fromARGB(
                            179, 6, 6, 6), // Slightly lighter color
                        fontSize: 20, // Updated font size
                        fontWeight: FontWeight.w800, // Updated font weight
                        fontFamily: 'Georgia', // Updated font family
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
