import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoneByAgent extends StatelessWidget {
  const DoneByAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Delivered Orders',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
        centerTitle: false,
        toolbarHeight: 80,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donebyagents').orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = documents[index];
                String noteText = document['note'];

                return Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(
                      noteText,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No confirmed requests.."));
          }
        },
      ),
    );
  }
}
