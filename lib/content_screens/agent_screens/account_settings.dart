// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool agentState = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAgentDetails();
  }

  void fetchAgentDetails() async {
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await firestore.collection('agents').doc(user.uid).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        nameController.text = data['name'] ?? '';
        emailController.text = data['email'] ?? '';
        mobileController.text = data['mobile'] ?? '';
        addressController.text = data['address'] ?? '';
        agentState = data['agentState'] ?? false;
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void updateAgentDetails() async {
    User? user = auth.currentUser;
    if (user != null) {
      await firestore.collection('agents').doc(user.uid).set({
        'name': nameController.text,
        'email': emailController.text,
        'mobile': mobileController.text,
        'address': addressController.text,
        'agentState': agentState,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Details updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: mobileController,
                      decoration: const InputDecoration(
                        labelText: 'Mobile',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: addressController,
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SwitchListTile(
                      title: const Text('Available'),
                      value: agentState,
                      onChanged: (bool value) {
                        setState(() {
                          agentState = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: updateAgentDetails,
                        child: const Text('Update Details'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
