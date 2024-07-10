import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:passdata/firebase_datapass/orders/customerorders.dart';

import 'package:passdata/services/firestore.dart';

class Customermenus extends StatefulWidget {
  const Customermenus({super.key});

  @override
  State<Customermenus> createState() => _CustomermenusState();
}

class _CustomermenusState extends State<Customermenus> {
  //firestore
   final SellerMenusService sellermenusService = SellerMenusService();
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
                      sellermenusService.addNote(textController.text);
                    }
                    //update an existing note
                    else {
                      sellermenusService.updateNote(docID, textController.text);
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
            text: 'Menus in this store',
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
        stream: sellermenusService.getNotesStream(),
        builder: (context, snapshot) {
          //if we have the data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            //display as List
            return GridView.builder(
              padding: const EdgeInsets.all(8.0), // Add padding around the GridView
              itemCount: notesList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
                crossAxisSpacing: 8.0, // Horizontal spacing between tiles
                mainAxisSpacing: 8.0, // Vertical spacing between tiles
                childAspectRatio: 4 / 2, // Aspect ratio of each tile
              ),
              itemBuilder: (context, index) {
                // get each individual doc
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                // get note from each doc
                Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                // display as a decorated tile
                return Card(
                  elevation: 5.0, // Add elevation for shadow effect
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  ),
                  child: GridTile(
                    header: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        noteText,
                        style: const TextStyle(
                          fontSize: 20.0, // Font size
                          fontWeight: FontWeight.bold, // Bold text
                          color: Colors.black87, // Text color
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10.0), // Add padding inside the tile
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50], // Background color
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            //if there is no data return nothing
            return const Text("No notes..");
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around the button
        child: ElevatedButton(
          onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerOrders(),
                    ));
          },
          child: const Text('Order Now', style: TextStyle(fontSize: 20.0)),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            backgroundColor: Colors.red, // Increase button height
           //primary: Colors.green, // Button background color
          ),
        ),
      ),
    );
  }
}
