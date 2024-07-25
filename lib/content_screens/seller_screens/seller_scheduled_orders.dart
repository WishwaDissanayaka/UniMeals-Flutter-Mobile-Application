import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passdata/content_screens/seller_screens/calling_agent.dart'; // Import the AvailableAgentsPage

class SellerScheduledOrdersPage extends StatelessWidget {
  const SellerScheduledOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scheduled Orders',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('scheduled_orders').orderBy('scheduledDateTime', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> ordersList = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: ordersList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = ordersList[index];
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                String foodName = data['foodName'];
                int quantity = data['quantity'];
                String address = data['address'];
                String phone = data['phone'];
                Timestamp timestamp = data['scheduledDateTime'];

                DateTime scheduledDateTime = timestamp.toDate();

                return Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodName,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text('Quantity: $quantity'),
                        Text('Address: $address'),
                        Text('Phone: $phone'),
                        Text('Scheduled at: ${scheduledDateTime.toLocal()}'),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CallingAvailableAgents(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blue, // Customize button color as needed
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Adjust padding as needed
                              textStyle: const TextStyle(fontSize: 16), // Adjust text style as needed
                            ),
                            child: const Text('Call Agent'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
