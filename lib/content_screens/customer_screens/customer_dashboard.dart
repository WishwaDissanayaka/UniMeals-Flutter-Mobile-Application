// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, duplicate_ignore

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:passdata/common_components.dart/contact_admin.dart';
import 'package:passdata/content_screens/customer_screens/customermenus.dart';

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
      home: const CustomerDashboardScreen(),
    );
  }
}

class CustomerDashboardScreen extends StatefulWidget {
  const CustomerDashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerDashboardScreenState createState() => _CustomerDashboardScreenState();
}

class _CustomerDashboardScreenState extends State<CustomerDashboardScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    'Menus',
    'Customize Orders',
    'Contact Admin'
  ];

  void _onItemTapped(int index) {
    if (index == 3) {
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
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
        centerTitle: true,
        toolbarHeight: 80,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // ignore: prefer_const_constructors
            ListTile(),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text('Menus'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Schedule Customize Orders'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Contact Admin'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: const <Widget>[
          // CustomerDashboardView(),
          Customermenus(),
          ScheduledOrderingPage(), // Replace with actual widget
          ProfileView(),
        ],
      ),
    );
  }
}







//-------------------------Customer Sceduled Order--------------------------//



class ScheduledOrderingPage extends StatefulWidget {
  const ScheduledOrderingPage({super.key});

  @override
  State<ScheduledOrderingPage> createState() => _ScheduledOrderingPageState();
}

class _ScheduledOrderingPageState extends State<ScheduledOrderingPage> {
  final TextEditingController foodNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  DateTime? scheduledDate;
  TimeOfDay? scheduledTime;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void scheduleOrder() async {
    if (foodNameController.text.isEmpty ||
        quantityController.text.isEmpty ||
        addressController.text.isEmpty ||
        phoneController.text.isEmpty ||
        scheduledDate == null ||
        scheduledTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    DateTime scheduledDateTime = DateTime(
      scheduledDate!.year,
      scheduledDate!.month,
      scheduledDate!.day,
      scheduledTime!.hour,
      scheduledTime!.minute,
    );

    await firestore.collection('scheduled_orders').add({
      'foodName': foodNameController.text,
      'quantity': int.parse(quantityController.text),
      'address': addressController.text,
      'phone': phoneController.text,
      'scheduledDateTime': scheduledDateTime,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order scheduled successfully')),
    );

    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != scheduledDate) {
      setState(() {
        scheduledDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != scheduledTime) {
      setState(() {
        scheduledTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: foodNameController,
              decoration: const InputDecoration(
                labelText: 'Reqiured Food Details',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: const Text('Select Date'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectTime(context),
                    child: const Text('Select Time'),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: scheduleOrder,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 25, 196, 33), // Set the text color to white
                  padding: const EdgeInsets.symmetric(vertical: 16.0), // Adjust padding as needed
                  textStyle: const TextStyle(fontSize: 18), // Adjust text style as needed
                ),
                child: const Text('SCHEDULE ORDER'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

