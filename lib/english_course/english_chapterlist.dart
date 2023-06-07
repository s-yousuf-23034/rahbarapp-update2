import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahbarapp/english_course/bloc/english_bloc.dart';
import 'package:rahbarapp/english_course/bloc/english_event.dart';
import 'package:rahbarapp/english_course/bloc/english_state.dart';
import 'package:rahbarapp/english_course/chapter_detail_screen.dart';

class EnglishChapterListScreen extends StatefulWidget {
  @override
  _EnglishChapterListScreenState createState() =>
      _EnglishChapterListScreenState();
}

class _EnglishChapterListScreenState extends State<EnglishChapterListScreen> {
  late EnglishChapterBloc _englishChapterBloc;
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    _englishChapterBloc = EnglishChapterBloc();
    _englishChapterBloc.add(LoadEnglishChaptersEvent());

    Firebase.initializeApp().then((_) {
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('English Chapters'),
      ),
      body: BlocBuilder<EnglishChapterBloc, EnglishChapterState>(
        bloc: _englishChapterBloc,
        builder: (context, state) {
          if (state is EnglishChapterLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is EnglishChapterLoadedState) {
            return ListView.builder(
              itemCount: state.englishChapters.length,
              itemBuilder: (context, index) {
                final chapter = state.englishChapters[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  title: Text(
                    chapter.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  //subtitle: Text('Video URL: ${chapter.videoUrl}'),
                  trailing: chapter.quizAttempted
                      ? CircleAvatar(
                          backgroundColor: Colors.amber,
                          child: Icon(
                            Icons.check,
                            color: Colors.deepOrange,
                          ),
                        )
                      : null,
                  onTap: () async {
                    if (chapter != null) {
                      print('Tapped on chapter: ${chapter.name}');
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: _englishChapterBloc,
                            child: ChapterDetailScreen(chapter: chapter),
                          ),
                        ),
                      );
                      _englishChapterBloc.add(LoadEnglishChaptersEvent());
                    }
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text('Failed to load chapters.'),
            );
          }
        },
      ),
    );
  }

  Future<void> _updateChapterAttemptStatus(
      String chapterName, bool attempted) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        final userId = user.uid;
        final chapterRef =
            _firestore.collection('English Chapter').doc(chapterName);
        await chapterRef
            .collection('attempts')
            .doc(userId)
            .set({'attempted': attempted});
      }
    } catch (e) {
      print('Failed to update chapter attempt status: $e');
    }
  }

  @override
  void dispose() {
    _englishChapterBloc.close();
    super.dispose();
  }
}
