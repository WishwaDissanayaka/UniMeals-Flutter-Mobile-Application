import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:passdata/services/firestore.dart';

class AgentNotes extends StatefulWidget {
  const AgentNotes({super.key});

  @override
  State<AgentNotes> createState() => _AgentNotesState();
}

class _AgentNotesState extends State<AgentNotes> {
  //firestore
  final AgentNotesService agentnotesService = AgentNotesService();
  //text controller
  final TextEditingController textController = TextEditingController();


  // open a dialog box to add a note
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
                    //add new note
                    if (docID == null) {
                      agentnotesService.addNote(textController.text);
                    }
                    //update an existing note
                    else {
                      agentnotesService.updateNote(docID, textController.text);
                    }

                    //clear the text controller
                    textController.clear();
                    //close the box
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            text: 'Agent Personal Notes',
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


        floatingActionButton: FloatingActionButton(
          onPressed: openNoteBox,
          child: const Icon(Icons.add),
        ),
      
      
        body: StreamBuilder<QuerySnapshot>(
          stream: agentnotesService.getNotesStream(),
          builder: (context, snapshot) {
            //if we have the data, get all the docs
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;

              //display as List
              return ListView.builder(
                  itemCount: notesList.length,
                  itemBuilder: (context, index) {
                    // get each individual doc
                    DocumentSnapshot document = notesList[index];
                    String docID = document.id;

                    //get note from each doc
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    String noteText = data['note'];

                    //dispay as a list title
                    return ListTile(
                        title: Text(noteText),
                        trailing:
                            Row(mainAxisSize: MainAxisSize.min, children: [
                          //update button
                          IconButton(
                            onPressed: () => openNoteBox(docID: docID),
                            icon: const Icon(Icons.settings),
                          ),

                          //Delete button
                          IconButton(
                            onPressed: () => agentnotesService.deleteNote(docID),
                            icon: const Icon(Icons.delete),
                          ),
                        ]));
                  });
            }

            //if there is no data return nothing
            else {
              return const Text("No notes..");
            }
          },
        ));
  }
}
