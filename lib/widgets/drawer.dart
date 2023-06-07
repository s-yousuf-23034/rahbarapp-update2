import 'package:flutter/material.dart';
import 'package:rahbarapp/Zoom/ZoomClass.dart';
import 'package:rahbarapp/home/home.dart';
import 'package:rahbarapp/login/Login.dart';
import 'package:rahbarapp/pages/FAQs.dart';
import 'package:rahbarapp/pages/setting.dart';

class AppDrawer extends StatefulWidget {
  final String username;
  final bool isAdmin;

  AppDrawer({
    required this.username,
    required this.isAdmin,
  });

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<String> avatarOptions = [
    'assets/images/default.png',
    'assets/images/male.png',
    'assets/images/female.png',
    'assets/images/female1.png',
    'assets/images/male1.png',
  ];

  String selectedAvatar = 'assets/images/default.png';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              color: Colors.amber,
              padding: EdgeInsets.only(top: 32, bottom: 16),
              child: Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(selectedAvatar),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.username,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButton<String>(
                      value: selectedAvatar,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedAvatar = newValue;
                          });
                        }
                      },
                      items: avatarOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Color.fromARGB(255, 60, 5, 69),
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.calculate),
                        title: Text('Maths Progress'),
                        onTap: () {
                          // Handle navigation to Maths Progress
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.book),
                        title: Text('English Progress'),
                        onTap: () {
                          // Handle navigation to English Progress
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.description),
                        title: Text('Mock Tests'),
                        onTap: () {
                          // Handle navigation to Mock Tests
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.video_call),
                        title: Text('ZOOM Class'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ZoomClass(),
                            ),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.settings),
                        title: Text('Settings'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsScreen(
                                username: widget.username,
                                isAdmin: widget.isAdmin,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.question_answer),
                        title: Text('FAQs'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FAQsScreen(
                                username: widget.username,
                                isAdmin: widget.isAdmin,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Sign Out'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                      ),
                    ),
                    //  Card(
                    //   child: ListTile(
                    //     leading: Icon(Icons.question_answer),
                    //     title: Text('Quiz'),
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => QuizScreen(

                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
