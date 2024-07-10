import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passdata/firebase_datapass/orders/agentorders.dart';
import 'package:passdata/firebase_datapass/orders/customerorders.dart';
import 'package:passdata/services/firestore.dart';

class SellerOrders extends StatefulWidget {
  const SellerOrders({super.key});

  @override
  State<SellerOrders> createState() => _SellerOrdersState();
}

class _SellerOrdersState extends State<SellerOrders> {
  // Firestore
  final CustomerOrderService customerorderService = CustomerOrderService();
  // Text controller
  final TextEditingController textController = TextEditingController();

  // Open a dialog box to add a note
  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            hintText: 'Add your personal notes here !',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Add new note
              if (docID == null) {
                customerorderService.addNote(textController.text);
              }
              // Update an existing note
              else {
                customerorderService.updateNote(docID, textController.text);
              }

              // Clear the text controller
              textController.clear();
              // Close the box
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            text: 'Orders',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            children: [],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: customerorderService.getNotesStream(),
        builder: (context, snapshot) {
          // If we have the data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;



            // Display as List
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // Get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                // Get note from each doc
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                // Display as a decorated tile
                return Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        noteText,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      
                    ),
                    tileColor: Colors.blueGrey[50],
                    contentPadding: const EdgeInsets.all(10.0),
                    onTap: () {
                      // Handle tile tap, if needed
                    },
                  ),
                );
              },
            );




          } else {
            // If there is no data, return nothing
            return const Center(
              child: Text("No notes.."),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AgentOrders(),
              ),
            );
          },
          child: const Text('Call Agent', style: TextStyle(fontSize: 20.0)),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            backgroundColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
