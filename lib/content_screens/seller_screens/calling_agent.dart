import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passdata/firebase_datapass/orders/agentorders.dart';

class CallingAvailableAgents extends StatelessWidget {
  const CallingAvailableAgents({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Available Agents',
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
        stream: firestore
            .collection('agents')
            .where('agentState', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> agentsList = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: agentsList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = agentsList[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                String name = data['name'];
                String email = data['email'];
                String mobile = data['mobile'];
                String address = data['address'];

                return Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: $email'),
                        Text('Mobile: $mobile'),
                        Text('Address: $address'),
                        const SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AgentOrders(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors
                                  .blue, // Customize button color as needed
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0), // Adjust padding as needed
                              textStyle: const TextStyle(
                                  fontSize: 16), // Adjust text style as needed
                            ),
                            child: const Text('Call the Agent'),
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
