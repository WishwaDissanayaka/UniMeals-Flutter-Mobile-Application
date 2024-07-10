import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'About Us',
            style: TextStyle(
              fontSize: 24, // Increase font size of app bar title
              fontWeight: FontWeight.bold, // Make app bar title bold
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 92, 247, 26),
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
