import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../firebase_datapass/orders/customer_ordering.dart';  // Import the new order page

import 'package:passdata/services/firestore.dart';

class Customermenus extends StatefulWidget {
  const Customermenus({super.key});

  @override
  State<Customermenus> createState() => _CustomermenusState();
}

class _CustomermenusState extends State<Customermenus> {
  // Firestore
  final SellerMenusService sellermenusService = SellerMenusService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: sellermenusService.getNotesStream(),
        builder: (context, snapshot) {
          // If we have the data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;
            
            // Display as GridView
            return GridView.builder(
              padding: const EdgeInsets.all(1), // Add padding around the GridView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of tiles in a row
                crossAxisSpacing: 4.0, // Spacing between columns
                mainAxisSpacing: 4.0, // Spacing between rows
                childAspectRatio: 1.0, // Aspect ratio of each tile
              ),
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // Get each individual doc
                DocumentSnapshot document = notesList[index];

                // Get note from each doc
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                // Display as a decorated tile
                return Card(
                  elevation: 5.0, // Add elevation for shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPage(itemName: noteText),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          noteText,
                          style: const TextStyle(
                            fontSize: 15.0, // Font size
                            fontWeight: FontWeight.bold, // Bold text
                            color: Colors.black87, // Text color
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8.0),
                        const Icon(
                          Icons.delivery_dining,
                          color: Colors.green,
                          size: 30.0,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            // If there is no data return nothing
            return const Center(child: Text("Available Menus Loading..."));
          }
        },
      ),
    );
  }
}
