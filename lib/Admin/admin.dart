import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String id;
  late String title;
  late String content;

  Announcement({required this.id, required this.title, required this.content});
}

class Admin {
  final String email;
  final String password;
  List<Announcement> announcements = [];

  Admin({required this.email, required this.password});

  bool isAdmin(String email, String password) {
    // Replace this with your actual admin authentication logic
    // You can use your database or any other method to validate the admin credentials
    return email == 'laiba@gmail.com' && password == '12345678';
  }

  void createAnnouncement(String title, String content) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    Announcement announcement =
        Announcement(id: id, title: title, content: content);
    announcements.add(announcement);
    print('Announcement created: $title');
  }

  void updateAnnouncement(String announcementId, String title, String content) {
    Announcement? announcement;
    for (var ann in announcements) {
      if (ann.id == announcementId) {
        announcement = ann;
        break;
      }
    }
    if (announcement != null) {
      announcement.title = title;
      announcement.content = content;
      print('Announcement updated: $title');
    } else {
      print('Announcement not found');
    }
  }

  void deleteAnnouncement(String announcementId) {
    Announcement? announcement;
    for (var ann in announcements) {
      if (ann.id == announcementId) {
        announcement = ann;
        break;
      }
    }
    if (announcement != null) {
      announcements.remove(announcement);
      print('Announcement deleted: ${announcement.title}');
    } else {
      print('Announcement not found');
    }
  }

  Future<List<Announcement>> getAnnouncements() async {
    List<Announcement> announcements = [];
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('announcements').get();

      List<QueryDocumentSnapshot> documents = snapshot.docs;

      for (var document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        Announcement announcement = Announcement(
          id: document.id,
          title: data['title'],
          content: data['content'],
        );
        announcements.add(announcement);
      }
    } catch (e) {
      print('Error retrieving announcements: $e');
    }
    return announcements;
  }
}
