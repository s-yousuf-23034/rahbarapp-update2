import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ZoomClass extends StatefulWidget {
  @override
  _ZoomClassState createState() => _ZoomClassState();
}

class _ZoomClassState extends State<ZoomClass> {
  final String adminEmail = 'laiba@gmail.com';
  // final String username;

  //ZoomClass({required this.username});

  Future<QuerySnapshot<Map<String, dynamic>>> getAnnouncements() async {
    return FirebaseFirestore.instance.collection('announcements').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoom Announcements'),
        backgroundColor: Colors.amber, // Set the app bar color to mustard
      ),
      // drawer: AppDrawer(
      //   this.username,
      // ),
      backgroundColor: Color.fromARGB(255, 60, 5,
          69), // Set the background color of the whole screen to purple
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: getAnnouncements(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors
                            .white, // Set the color of the loading indicator to white
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  List<QueryDocumentSnapshot<Map<String, dynamic>>>
                      announcements = snapshot.data!.docs;

                  return ListView.separated(
                    itemCount: announcements.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      color:
                          Colors.white, // Set the color of the divider to white
                    ),
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Map<String, dynamic>> announcement =
                          announcements[index];
                      Map<String, dynamic> data = announcement.data();

                      return ListTile(
                        title: Text(
                          data['title'],
                          style: TextStyle(
                            color: Colors.white, // Set the text color to white
                            fontSize: 18, // Set the font size to 18
                          ),
                        ),
                        subtitle: Text(
                          data['content'],
                          style: TextStyle(
                            color: Colors.white, // Set the text color to white
                            fontSize: 16, // Set the font size to 16
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
