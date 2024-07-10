

// Login Screen Class , Login as a ///////////////////////////

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            text: 'Uni',
            style: TextStyle(
              color: Colors.black,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'Meals',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '\nOrder any Meals arround You !',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
        centerTitle: true,
        toolbarHeight: 150,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Text(
                  'Login as a ',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Button : Agent
            Center(
              // Center the passenger login button
              child: SizedBox(
                width: 150,
                height: 150,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/agent_login');
                  },
                  icon: const Column(
                    children: [
                      Icon(Icons.delivery_dining,
                          size: 90, color: Colors.black),
                      SizedBox(height: 5),
                      Text(
                        'Agent',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  label: const Text(''),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.black, width: 1),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), // Small space added here

            // Button : Seller
            Center(
              // Center the pilot login button
              child: SizedBox(
                width: 150,
                height: 150,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/seller_login');
                  },
                  icon: const Column(
                    children: [
                      Icon(Icons.store_mall_directory,
                          size: 90, color: Colors.black),
                      SizedBox(height: 5),
                      Text(
                        'Seller',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  label: const Text(''),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.black, width: 1),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), // Small space added here

            // Button : Customer

            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/customer_login');
                  },
                  icon: const Column(
                    children: [
                      Icon(Icons.food_bank_sharp,
                          size: 90, color: Colors.black),
                      SizedBox(height: 5),
                      Text(
                        'Customer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  label: const Text(''),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: const BorderSide(color: Colors.black, width: 1),
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
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