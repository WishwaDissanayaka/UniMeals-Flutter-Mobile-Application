import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passdata/content_screens/seller_screens/calling_agent.dart';
import 'package:passdata/content_screens/seller_screens/seller_scheduled_orders.dart';

class SellerOrdersPage extends StatefulWidget {
  const SellerOrdersPage({super.key});

  @override
  State<SellerOrdersPage> createState() => _SellerOrdersPageState();
}

class _SellerOrdersPageState extends State<SellerOrdersPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('orders').orderBy('timestamp', descending: true).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<DocumentSnapshot> ordersList = snapshot.data!.docs;

                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: ordersList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = ordersList[index];
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                      String itemName = data['item'];
                      int quantity = data['quantity'];
                      String address = data['address'];
                      String phone = data['phone'];
                      Timestamp timestamp = data['timestamp'];

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
                                itemName,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text('Quantity: $quantity'),
                              Text('Address: $address'),
                              Text('Phone: $phone'),
                              Text('Ordered at: ${timestamp.toDate().toString()}'),
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
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SellerScheduledOrdersPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(218, 214, 38, 35), // Customize button color as needed
                  padding: const EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
                  textStyle: const TextStyle(fontSize: 18), // Adjust text style as needed
                ),
                child: const Text('Customize Order Request'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
