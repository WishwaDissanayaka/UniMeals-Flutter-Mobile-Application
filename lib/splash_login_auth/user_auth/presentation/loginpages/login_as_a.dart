import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_category_provider.dart';

import 'package:passdata/common_components.dart/custom_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: const CustomAppBar01(),

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

            // Button: Customer
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<UserCategoryProvider>().setUserCategory('customer');
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: const Column(
                    children: [
                      Icon(Icons.food_bank_sharp, size: 90, color: Colors.black),
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
            const SizedBox(height: 30),



            // Button: Seller
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<UserCategoryProvider>().setUserCategory('seller');
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: const Column(
                    children: [
                      Icon(Icons.store_mall_directory, size: 90, color: Colors.black),
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
            const SizedBox(height: 30),



            // Button: Agent
            Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.read<UserCategoryProvider>().setUserCategory('agent');
                    Navigator.pushNamed(context, '/login');
                  },
                  icon: const Column(
                    children: [
                      Icon(Icons.delivery_dining, size: 90, color: Colors.black),
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
            const SizedBox(height: 30),


          ],
        ),
      ),
    );
  }
}
