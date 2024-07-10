import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Help and Support',
            style: TextStyle(
              fontSize: 24, // Increase font size of app bar title
              fontWeight: FontWeight.bold, // Make app bar title bold
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 92, 247, 26),
          toolbarHeight: 100,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Help and Support',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text(
                  'At UniMeal, we\'re dedicated to providing excellent support to our users. If you have any questions, encounter issues, or need assistance while using our app, there are several ways to get help:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  '1. FAQs',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Check out our Frequently Asked Questions (FAQs) section within the app. We\'ve compiled a list of common queries and their answers to help you troubleshoot issues and find solutions quickly.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  '2. Contact Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'If you can\'t find the answer to your question in the FAQs or need further assistance, you can reach out to our support team directly. Simply navigate to the "Contact Us" section in the app and send us a message. Our support team will respond to your inquiry as soon as possible.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  '3. In-App Help',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Many features within the app include built-in help guides or tooltips to provide you with information and guidance right when you need it. Look out for the "?" icon or help buttons throughout the app for contextual assistance.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  '4. Social Media',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Connect with us on social media platforms such as Twitter, Facebook, or Instagram. We regularly share updates, announcements, and tips to help you make the most out of your UniMeal experience. Feel free to send us a message or tag us in your posts if you have any questions or feedback.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  '5. Community Forums',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Join our community forums to interact with other users, share experiences, and exchange tips and tricks for using the app effectively. Our community is a valuable resource for getting support and learning from the experiences of fellow users.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  '6. Feedback and Suggestions',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We value your feedback and suggestions for improving the app. If you have ideas for new features, improvements, or enhancements, please let us know! Your input helps us prioritize our development efforts and ensure that UniMeal meets your needs.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  '7. Privacy and Security',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Your privacy and security are important to us. If you have any concerns about privacy practices or data security within the app, please refer to our Privacy Policy or contact our support team for assistance.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Remember, we\'re here to help make your food ordering experience as smooth and enjoyable as possible. Don\'t hesitate to reach out if you need assistance or have any questions!',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your message...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Submit the message
                    // You can implement the functionality to submit the message here
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
