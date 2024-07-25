import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:passdata/content_screens/agent_screens/account_settings.dart';


import 'package:passdata/content_screens/agent_screens/other_hotels.dart';
import 'package:passdata/common_components.dart/contact_admin.dart';
import 'package:passdata/content_screens/agent_screens/agent_notes.dart';

import 'package:passdata/firebase_datapass/orders/agentorders_toagent.dart';
import 'package:passdata/firebase_datapass/orders/done_by_agent.dart';

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
      home: const AgentDashboardScreen(),
    );
  }
}

class AgentDashboardScreen extends StatefulWidget {
  const AgentDashboardScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AgentDashboardScreenState createState() => _AgentDashboardScreenState();
}

class _AgentDashboardScreenState extends State<AgentDashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            text: 'Agent Dashboard',
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

      
      body: _getWidgetForIndex(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Account Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Contact Agent',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
      ),
    );
  }

  Widget _getWidgetForIndex(int index) {
    switch (index) {
      case 0:
        return const AgentDashboardView();
      case 1:
        return const AccountSettings();
      case 2:
        return const ProfileView();
      default:
        return const Center(
          child: Text('Invalid Page'),
        );
    }
  }
}

class AgentDashboardView extends StatelessWidget {
  const AgentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAgentDashboardButton(
              Icons.notification_add_rounded,
              'Order Requests',
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AgentOrderstoagent(),
                    ));
              },
            ),
            const SizedBox(width: 32), // Increase the spacing
            _buildAgentDashboardButton(
              Icons.store_mall_directory,
              'Connected Stores',
              () {
                // Navigate to timetable screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyPdfViewer(),
                    ));
              },
            ),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAgentDashboardButton(
              Icons.done_all_sharp,
              'Done Orders',
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DoneByAgent(),
                    ));

              },
            ),
            const SizedBox(width: 32), // Increase the spacing
            _buildAgentDashboardButton(
              Icons.notes_sharp,
              'My Notes',
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AgentNotes(),
                    ));
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAgentDashboardButton(
    IconData iconData,
    String label,
    VoidCallback onTap,
  ) {
    return SizedBox(
      width: 150, // Set the width of the button
      height: 150, // Set the height of the button
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Set the border radius
          ),
          side: const BorderSide(color: Colors.black), // Add a black border
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 45, // Set the icon size
              color: Colors.black, // Set the icon color
            ),
            const SizedBox(height: 5), // Adjust the spacing
            Flexible(
              // Added Flexible widget
              child: Text(
                label,
                textAlign: TextAlign.center, // Center align the text
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold, // Set text weight to bold
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}