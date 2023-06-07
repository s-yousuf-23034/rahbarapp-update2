import 'package:flutter/material.dart';
import 'package:rahbarapp/Course/CourseList.dart';
import 'package:rahbarapp/widgets/drawer.dart';

class SettingsScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final String username;
  final bool isAdmin;

  SettingsScreen({required this.username, required this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.amber,
      ),
      drawer: AppDrawer(
        username: username,
        isAdmin: isAdmin,
      ),
      // drawer: AppDrawer(this.username),
      body: Container(
        color: Color.fromARGB(255, 60, 5, 69),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Security',
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
            GestureDetector(
              onTap: () {
                // Handle 'Change Password' onTap
              },
              child: Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Handle 'Change Username' onTap
              },
              child: Text(
                'Change Username',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 24.0),
            Text(
              'General',
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
            GestureDetector(
              onTap: () {
                // Handle 'Change Username' onTap
              },
              child: Text(
                'Change Username',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                // Handle 'Change Username' onTap
              },
              child: Text(
                'Change Username',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),
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
                child: Text('Back to the Courses'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  textStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
