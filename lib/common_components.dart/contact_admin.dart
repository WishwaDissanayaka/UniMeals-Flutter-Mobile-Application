import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hotline No : 070 3281271',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 10),
          const Text(
            '@ All Rights reserved',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HelpSupportPage(),
                ),
              );
            },
            child: const Text('Help & Support'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 120),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: const BorderSide(color: Colors.black),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsPage(),
                ),
              );
            },
            child: const Text('About Us'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/login'));
              // Implement log out functionality here
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}




class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

      appBar: AppBar(
        title: const Text(
          'About us',
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


        body: const Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About UniMeal: Your Food Ordering Companion',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to UniMeal, your ultimate food ordering companion! We are dedicated to revolutionizing the way you experience food delivery, making your meals more convenient, predictable, and enjoyable.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Our Vision',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'At UniMeal, we envision a world where food ordering is seamless and stress-free for everyone. Our goal is to empower diners with real-time tracking information, ensuring they can navigate through their food choices and cravings with ease.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Who We Are',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'UniMeal is developed by a team of passionate individuals with expertise in software development, data analysis, and the food industry. We are driven by a shared vision of leveraging technology to enhance the food ordering experience for customers and restaurants alike.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Our Values',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  '- Freshness: We prioritize delivering fresh and delicious meals, ensuring that you have a delightful dining experience.',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '- Accessibility: Our app is designed to be accessible to all users, with a user-friendly interface and features that cater to diverse needs and preferences.',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '- Efficiency: We understand the value of time, which is why we strive to provide efficient solutions that streamline your food ordering experience.',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '- Collaboration: We believe in collaborating with restaurants, delivery partners, and our users to continuously improve our app and enhance the overall food delivery ecosystem.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Key Features',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  '- Real-time Order Tracking: Track your food order\'s status in real-time, allowing you to plan your meals more effectively.',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '- Customized Recommendations: Receive personalized meal recommendations based on your preferences and past orders.',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '- Wide Range of Cuisines: Access a diverse selection of restaurants and cuisines, catering to all your cravings.',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '- Promotions and Discounts: Enjoy exclusive promotions and discounts, making your meals more affordable.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Get in Touch',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'We\'re here to support you on your food ordering adventures! If you have any questions, feedback, or suggestions, please don\'t hesitate to reach out to us. You can contact us through the app or connect with us on social media.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Thank you for choosing UniMeal as your food ordering companion. We look forward to enhancing your dining experience!',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class HelpSupportPage extends StatelessWidget {
  HelpSupportPage({super.key});

  // Controllers for user input
  final TextEditingController messageController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();

  // Firestore instance
  final CollectionReference helpAndSupport =
      FirebaseFirestore.instance.collection('helpandsupport');

  // Function to submit user input to Firestore
  Future<void> submitHelpSupport(String message, String contactNumber) {
    return helpAndSupport.add({
      'message': message,
      'contactNumber': contactNumber,
      'timestamp': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

      appBar: AppBar(
        title: const Text(
          'Helps and Supports',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 247, 26),
        centerTitle: true,
        toolbarHeight: 80,
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
                TextField(
                  controller: messageController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your message here...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: contactNumberController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your contact number here...',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final message = messageController.text;
                    final contactNumber = contactNumberController.text;
                    if (message.isNotEmpty && contactNumber.isNotEmpty) {
                      submitHelpSupport(message, contactNumber).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Message sent successfully!'),
                          ),
                        );
                        messageController.clear();
                        contactNumberController.clear();
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to send message: $error'),
                          ),
                        );
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter both message and contact number.'),
                        ),
                      );
                    }
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
