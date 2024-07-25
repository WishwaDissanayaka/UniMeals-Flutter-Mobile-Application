// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:passdata/services/firestore.dart';

class CustomerOrders extends StatefulWidget {
  const CustomerOrders({super.key});

  @override
  State<CustomerOrders> createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
  //firestore
  final CustomerOrderService customerorderService = CustomerOrderService();
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
                  hintText: 'Insert menus on Pre.Page / and TelNo',
                  ),
               ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    //add new note
                    if (docID == null) {
                      customerorderService.addNote(textController.text);
                    }
                    //update an existing note
                    else {
                      customerorderService.updateNote(docID, textController.text);
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
      // appBar: AppBar(
      //   title: RichText(
      //     text: const TextSpan(
      //       text: 'My Orders',
      //       style: TextStyle(
      //         color: Colors.black,
      //         fontSize: 30,
      //         fontWeight: FontWeight.bold,
      //       ),
      //       children: [],
      //     ),
      //   ),
      //   backgroundColor: const Color.fromARGB(255, 92, 247, 26),
      //   centerTitle: true,
      //   toolbarHeight: 100,
      // ),


        floatingActionButton: FloatingActionButton(
          onPressed: openNoteBox,
          child: const Icon(Icons.add),
        ),
      
      
        body: StreamBuilder<QuerySnapshot>(
          stream: customerorderService.getNotesStream(),
          builder: (context, snapshot) {
            //if we have the data, get all the docs
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;

              //display as List
return ListView.builder(
  padding: const EdgeInsets.all(8.0), // Add padding around the ListView
  itemCount: notesList.length,
  itemBuilder: (context, index) {
    // get each individual doc
    DocumentSnapshot document = notesList[index];
    String docID = document.id;

    // get note from each doc
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    String noteText = data['note'];

    // display as a decorated list item
    return Card(
      elevation: 5.0, // Add elevation for shadow effect
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Add margin between cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), // Rounded corners
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0), // Add padding inside the ListTile
        tileColor: Colors.blueGrey[50], // Background color
        title: Text(
          noteText,
          style: const TextStyle(
            fontSize: 18.0, // Font size
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.black87, // Text color
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
                          //update button
                          IconButton(
                            onPressed: () => openNoteBox(docID: docID),
                            icon: const Icon(Icons.settings),
                          ),

            // Delete button
            IconButton(
              onPressed: () => customerorderService.deleteNote(docID),
              icon: const Icon(Icons.delete, color: Colors.red), // Red delete icon
            ),
          ],
        ),
      ),
    );
  },
);

            }

            //if there is no data return nothing
            else {
              return const Text("No notes..");
            }
          },
        ));
  }
}
