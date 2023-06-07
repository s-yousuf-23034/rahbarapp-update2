import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ZoomAnnouncementPage extends StatefulWidget {
  final String userName;

  const ZoomAnnouncementPage({Key? key, required this.userName})
      : super(key: key);

  @override
  _ZoomAnnouncementPageState createState() => _ZoomAnnouncementPageState();
}

class _ZoomAnnouncementPageState extends State<ZoomAnnouncementPage> {
  DocumentSnapshot? selectedAnnouncement;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final String adminEmail = 'laiba@gmail.com';

  Future<QuerySnapshot<Map<String, dynamic>>> getAnnouncements() async {
    return FirebaseFirestore.instance.collection('announcements').get();
  }

  Future<void> createAnnouncement(String title, String content) async {
    await FirebaseFirestore.instance.collection('announcements').add({
      'title': title,
      'content': content,
    });

    setState(() {});
  }

  Future<void> updateAnnouncement(
      String announcementId, String title, String content) async {
    await FirebaseFirestore.instance
        .collection('announcements')
        .doc(announcementId)
        .update({
      'title': title,
      'content': content,
    });

    setState(() {});
  }

  Future<void> deleteAnnouncement(String announcementId) async {
    await FirebaseFirestore.instance
        .collection('announcements')
        .doc(announcementId)
        .delete();

    setState(() {});
  }

  // Function to handle logout
  void _logout() {
    // Add your logout logic here
    // For example, you can navigate to the login screen or clear the user session.
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoom Announcements'),
        backgroundColor: Colors.amber,
      ),
      backgroundColor: Color.fromARGB(255, 60, 5, 69),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            TextField(
              controller: contentController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Content',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                createAnnouncement(
                  titleController.text,
                  contentController.text,
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.amber,
                ),
              ),
              child: Text(
                'Create Announcement',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedAnnouncement != null) {
                  String announcementId = selectedAnnouncement!.id;
                  updateAnnouncement(
                    announcementId,
                    titleController.text,
                    contentController.text,
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.amber,
                ),
              ),
              child: Text(
                'Update Announcement',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedAnnouncement != null) {
                  String announcementId = selectedAnnouncement!.id;
                  deleteAnnouncement(announcementId);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.amber,
                ),
              ),
              child: Text(
                'Delete Announcement',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Expanded(
              child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: getAnnouncements(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  List<QueryDocumentSnapshot<Map<String, dynamic>>>
                      announcements = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: announcements.length,
                    itemBuilder: (context, index) {
                      QueryDocumentSnapshot<Map<String, dynamic>> announcement =
                          announcements[index];
                      Map<String, dynamic> data = announcement.data();

                      return ListTile(
                        title: Text(
                          data['title'],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          data['content'],
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              selectedAnnouncement = announcement;
                              titleController.text = data['title'];
                              contentController.text = data['content'];
                            });
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _logout();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.amber,
                ),
              ),
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
