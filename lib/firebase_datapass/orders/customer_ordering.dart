// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously, use_super_parameters

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passdata/common_components.dart/custom_app_bar.dart';

class OrderPage extends StatefulWidget {
  final String itemName;

  const OrderPage({Key? key, required this.itemName}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void placeOrder() async {
    if (quantityController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    await firestore.collection('orders').add({
      'item': widget.itemName,
      'quantity': int.parse(quantityController.text),
      'address': addressController.text,
      'phone': phoneController.text,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order placed successfully')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar01(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.itemName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: placeOrder,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 25, 196, 33), // Set the text color to white
              padding: const EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
              textStyle: const TextStyle(fontSize: 18), // Adjust text style as needed
            ),
            child: const Text('PLACE THE ORDER'),
          ),
        ),
          ],
        ),
      ),
    );
  }
}
