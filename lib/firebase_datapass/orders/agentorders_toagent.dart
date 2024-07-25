import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passdata/services/firestore.dart';

class AgentOrderstoagent extends StatefulWidget {
  const AgentOrderstoagent({super.key});

  @override
  State<AgentOrderstoagent> createState() => _AgentOrderstoagentState();
}

class _AgentOrderstoagentState extends State<AgentOrderstoagent> {
  final AgentOrderService agentorderService = AgentOrderService();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController telNoController = TextEditingController();
  TimeOfDay? selectedTime;
  Map<String, bool> confirmationStates = {};

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
              final combinedNote =
                  'Shop: ${shopNameController.text}, Tel: ${telNoController.text}, Time: ${selectedTime?.format(context) ?? 'No time'}';

              if (docID == null) {
                agentorderService.addNote(combinedNote);
              } else {
                agentorderService.updateNote(docID, combinedNote);
              }

              shopNameController.clear();
              telNoController.clear();
              selectedTime = null;
              Navigator.pop(context);
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  void _confirmRequest(String docID, String noteText) async {
    // Create a new document in 'donebyagents'
    await FirebaseFirestore.instance.collection('donebyagents').add({
      'note': noteText,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update the confirmation state
    setState(() {
      confirmationStates[docID] = true;
    });

    // Optionally: You might want to remove the document from the current collection if it's no longer needed
    await FirebaseFirestore.instance.collection('agentorders').doc(docID).delete();
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
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                bool isConfirmed = confirmationStates[docID] ?? false;

                List<String> noteParts = noteText.split(', ');
                String shopName = noteParts[0].replaceFirst('Shop: ', '');
                String telNo = noteParts[1].replaceFirst('Tel: ', '');
                String time = noteParts[2].replaceFirst('Time: ', '');

                return Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    color: isConfirmed ? Colors.green[50] : Colors.red[50],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: const EdgeInsets.all(10.0),
                          leading: const Icon(Icons.notifications, color: Colors.red),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Shop: $shopName',
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Tel: $telNo',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                'Time: $time',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isConfirmed)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.0),
                            child: Row(
                              children: [
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {
                                    _confirmRequest(docID, noteText);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 91, 162, 220),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                  ),
                                  child: const Text(
                                    'Confirm the request',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("Loading Agent Request from seller"));
          }
        },
      ),
    );
  }
}
