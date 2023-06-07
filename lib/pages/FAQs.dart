import 'package:flutter/material.dart';
import 'package:rahbarapp/Course/CourseList.dart';
import 'package:rahbarapp/widgets/drawer.dart';

class FAQsScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final String username;
  final bool isAdmin;

  FAQsScreen({required this.username, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQS'),
        backgroundColor: Colors.amber,
      ),
      drawer: AppDrawer(
        username: username,
        isAdmin: isAdmin,
      ),
      body: Container(
        color: Color.fromARGB(255, 60, 5, 69),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What is the purpose of this app?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 8.0),
              ),
              Text(
                'The purpose of this app is to provide students with a platform to prepare for exams, access study materials, and track their progress.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'How can I create an account on this app?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 8.0),
              ),
              Text(
                'You can create an account by clicking on the "Sign Up" button and providing your details.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'How can I track my progress?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 8.0),
              ),
              Text(
                'You can track your progress by using the progress tracker feature in the app',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'How often are study materials updated?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 8.0),
              ),
              Text(
                'Study materials are updated regularly to ensure that they are accurate and up-to-date',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'How do I register for the Zoom session?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 8.0),
              ),
              Text(
                'To register for the Zoom session, you need to create an account in the app and then navigate to the "Zoom Session" section. There, you will find information on how to sign up for the upcoming session.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'How do I join the Zoom session',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              Container(
                height: 1.0,
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 8.0),
              ),
              Text(
                ' To join the Zoom session, click on the link provided in the registration confirmation email or go to the "Zoom Session" section in the app and click on the "Join Session" button',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseList(
                          username: username,
                          isAdmin: isAdmin,
                        ),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.amber),
                  ),
                  child: Text(
                    'Back to the Courses',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
