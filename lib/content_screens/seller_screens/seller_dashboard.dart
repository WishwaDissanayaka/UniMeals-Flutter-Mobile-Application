// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:passdata/content_screens/agent_screens/other_hotels.dart';
import 'package:passdata/common_components.dart/contact_admin.dart';
import 'package:passdata/content_screens/seller_screens/available_agents.dart';
import 'package:passdata/services/firestore.dart';
import 'package:passdata/content_screens/seller_screens/seller_orders.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unimeal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SellerDashboardScreen(),
    );
  }
}







class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SellerDashboardScreenState createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  int _selectedIndex = 2;

  final List<String> _titles = [
    'My Menus',
    'Other Hotels',
    'My Orders',
    'Available Agents',
    'Settings',
    'Contact Admin'
  ];

  void _onItemTapped(int index) {
    if (index == 6) {
      Navigator.popUntil(context, ModalRoute.withName('/login'));
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pop(context); // Close the drawer after selecting an item
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
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


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // DrawerHeader(
            //   decoration: const BoxDecoration(
            //     color: Color.fromARGB(255, 255, 255, 255),
            //   ),
            //   child: const Text(
            //     'Menu',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 30,
            //     ),
            //   ),
            // ),
            ListTile(
            ),
            ListTile(
              leading: const Icon(Icons.cookie),
              title: const Text('My Orders'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.food_bank),
              title: const Text('My Menus'),
              onTap: () => _onItemTapped(0),
            ),
            
            ListTile(
              leading: const Icon(Icons.delivery_dining),
              title: const Text('Available Agents'),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.store_mall_directory),
              title: const Text('Other Hotels'),
              onTap: () => _onItemTapped(1),
            ),
            // ListTile(
            //   leading: const Icon(Icons.settings),
            //   title: const Text('Settings'),
            //   onTap: () => _onItemTapped(4),
            // ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Contact Admin'),
              onTap: () => _onItemTapped(5),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Log out'),
              onTap: () => _onItemTapped(6),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const <Widget>[
          Sellermenus(),
          MyPdfViewer(),
          SellerOrdersPage(),
          // SellerOrders(),
          AvailableAgents(), // Placeholder for Agents Page
          Center(child: Text('Settings Page')), // Placeholder for Settings Page
          ProfileView(),
        ],
      ),
    );
  }
}




class Sellermenus extends StatefulWidget {
  const Sellermenus({super.key});

  @override
  State<Sellermenus> createState() => _SellermenusState();
}

class _SellermenusState extends State<Sellermenus> {
  final SellerMenusService sellermenusService = SellerMenusService();
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void openNoteBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: foodNameController,
                    decoration: const InputDecoration(
                      hintText: 'Food Name',
                    ),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: const InputDecoration(
                      hintText: 'Price',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    String combinedText =
                        '${foodNameController.text} : Rs. ${priceController.text}';
                    if (docID == null) {
                      sellermenusService.addNote(combinedText);
                    } else {
                      sellermenusService.updateNote(docID, combinedText);
                    }
                    foodNameController.clear();
                    priceController.clear();
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
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: sellermenusService.getNotesStream(),
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

                return Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    tileColor: Colors.blueGrey[50],
                    title: Text(
                      noteText,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => openNoteBox(docID: docID),
                          icon: const Icon(Icons.settings),
                        ),
                        IconButton(
                          onPressed: () => sellermenusService.deleteNote(docID),
                          icon: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Loading My Available Menus..."),
            );
          }
        },
      ),
    );
  }
}
