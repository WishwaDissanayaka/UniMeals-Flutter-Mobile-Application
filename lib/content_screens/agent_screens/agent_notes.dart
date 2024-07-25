import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passdata/services/firestore.dart';

class AgentNotes extends StatefulWidget {
  const AgentNotes({super.key});

  @override
  State<AgentNotes> createState() => _AgentNotesState();
}

class _AgentNotesState extends State<AgentNotes> {
  // Firestore
  final AgentNotesService agentnotesService = AgentNotesService();
  // Text controller
  final TextEditingController textController = TextEditingController();

  // Open a dialog box to add a note
  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Add your personal notes here!',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Add new note
              if (docID == null) {
                agentnotesService.addNote(textController.text);
              }
              // Update an existing note
              else {
                agentnotesService.updateNote(docID, textController.text);
              }

              // Clear the text controller
              textController.clear();
              // Close the box
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
          TextButton(
            onPressed: () {
              // Close the box without saving
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Agent Personal Notes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
        centerTitle: true,
        toolbarHeight: 100,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: agentnotesService.getNotesStream(),
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
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      noteText,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Update button
                        IconButton(
                          onPressed: () => openNoteBox(docID: docID),
                          icon: const Icon(Icons.edit, color: Colors.blue),
                        ),
                        // Delete button
                        IconButton(
                          onPressed: () => agentnotesService.deleteNote(docID),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          // If there is no data return nothing
          else {
            return const Center(
              child: Text(
                "No notes available.",
                style: TextStyle(fontSize: 18.0),
              ),
            );
          }
        },
      ),
    );
  }
}
