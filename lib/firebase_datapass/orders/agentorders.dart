import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passdata/services/firestore.dart';

class AgentOrders extends StatefulWidget {
  const AgentOrders({super.key});

  @override
  State<AgentOrders> createState() => _AgentOrdersState();
}

class _AgentOrdersState extends State<AgentOrders> {
  // Firestore service
  final AgentOrderService agentorderService = AgentOrderService();
  // Text controllers
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController telNoController = TextEditingController();
  // Time controller
  TimeOfDay? selectedTime;

  // Map to track the confirmation state of each document
  Map<String, bool> confirmationStates = {};

  // Open a dialog box to add or update a note
  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: shopNameController,
              decoration: const InputDecoration(
                hintText: 'Insert Shop Name',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: telNoController,
              decoration: const InputDecoration(
                hintText: 'Insert Tel No',
              ),
            ),
            const SizedBox(height: 10),
            ListTile(
              title: const Text('Select Time'),
              trailing: IconButton(
                icon: const Icon(Icons.access_time),
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
              ),
              subtitle: selectedTime != null
                  ? Text(
                      'Selected Time: ${selectedTime!.format(context)}',
                      style: const TextStyle(color: Colors.black),
                    )
                  : const Text('No time selected'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Combine the fields into one string
              final combinedNote =
                  'Shop: ${shopNameController.text}, Tel: ${telNoController.text}, Time: ${selectedTime?.format(context) ?? 'No time'}';

              // Add a new note
              if (docID == null) {
                agentorderService.addNote(combinedNote);
              } 
              // Update an existing note
              else {
                agentorderService.updateNote(docID, combinedNote);
              }

              // Clear the text controllers and reset the time
              shopNameController.clear();
              telNoController.clear();
              selectedTime = null;
              // Close the dialog box
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
            text: 'Agent Requests',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openNoteBox(),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: agentorderService.getNotesStream(),
        builder: (context, snapshot) {
          // If we have the data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            // Display as List
            return ListView.builder(
              padding: const EdgeInsets.all(8.0), // Add padding around the ListView
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                // Get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                // Get note from each doc
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                // Get the confirmation state of this document
                bool isConfirmed = confirmationStates[docID] ?? false;

                // Split the combined note into separate fields
                List<String> noteParts = noteText.split(', ');
                String shopName = noteParts[0].replaceFirst('Shop: ', '');
                String telNo = noteParts[1].replaceFirst('Tel: ', '');
                String time = noteParts[2].replaceFirst('Time: ', '');

                // Display as a decorated list item
                return Card(
                  elevation: 5.0, // Add elevation for shadow effect
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Add margin between cards
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  ),
                  child: Container(
                    color: isConfirmed ? Colors.green[50] : Colors.red[50], // Change color based on confirmation
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(10.0), // Add padding inside the ListTile
                          leading: const Icon(Icons.notifications, color: Colors.red), // Notification icon
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shop: $shopName',
                                style: const TextStyle(
                                  fontSize: 18.0, // Font size
                                  fontWeight: FontWeight.bold, // Bold text
                                  color: Colors.black87, // Text color
                                ),
                              ),
                              Text(
                                'Tel: $telNo',
                                style: const TextStyle(
                                  fontSize: 16.0, // Font size
                                  color: Colors.black87, // Text color
                                ),
                              ),
                              Text(
                                'Time: $time',
                                style: const TextStyle(
                                  fontSize: 16.0, // Font size
                                  color: Colors.black87, // Text color
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () => agentorderService.deleteNote(docID),
                            icon: const Icon(Icons.delete, color: Colors.red), // Red delete icon
                          ),
                        ),
                        if (!isConfirmed)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              children: [
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          } 
          // If there is no data, return a message
          else {
            return const Center(child: Text("No notes.."));
          }
        },
      ),
    );
  }
}


