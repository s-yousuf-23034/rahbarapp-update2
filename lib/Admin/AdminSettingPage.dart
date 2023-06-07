import 'package:flutter/material.dart';
import 'package:rahbarapp/Quiz/QuizUploadEng.dart';
import 'package:rahbarapp/Quiz/QuizUploadMath.dart';
import 'package:rahbarapp/Zoom/ZoomAnnoucementPage.dart';
import 'package:rahbarapp/login/Login.dart';


class AdminSettingsPage extends StatelessWidget {
  final String userName;

  const AdminSettingsPage({Key? key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Admin Setting',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 60, 5, 69),
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            shrinkWrap: true,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to the ZoomAnnouncementPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZoomAnnouncementPage(
                        userName: userName,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.amber), // Set button color to amber
                ),
                child: Text('Go to Zoom Announcements Page'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizUploadEng(userName: userName),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.amber), // Set button color to amber
                ),
                child: Text('Upload Quiz for English'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizUploadMath(userName: userName),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.amber), // Set button color to amber
                ),
                child: Text('Upload Quiz for Math'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 60, 5, 69),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to the login screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: Text('Logout'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.amber), // Set button color to amber
            ),
          ),
        ),
      ),
    );
  }
}
