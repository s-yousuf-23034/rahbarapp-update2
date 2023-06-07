import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahbarapp/math_chapter/chapter_detail_screen.dart';

import 'bloc/mathchapter_bloc.dart';
import 'bloc/mathchapter_state.dart';

class MathChapterListScreen extends StatefulWidget {
  @override
  _MathChapterListScreenState createState() => _MathChapterListScreenState();
}

class _MathChapterListScreenState extends State<MathChapterListScreen> {
  late MathChapterBloc _mathChapterBloc;
  late FirebaseAuth _auth;
  late FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    _mathChapterBloc = MathChapterBloc();
    _mathChapterBloc.add(LoadMathChaptersEvent());

    Firebase.initializeApp().then((_) {
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maths Chapters'),
      ),
      body: BlocBuilder<MathChapterBloc, MathChapterState>(
        bloc: _mathChapterBloc,
        builder: (context, state) {
          if (state is MathChapterLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MathChapterLoadedState) {
            return ListView.builder(
              itemCount: state.mathChapters.length,
              itemBuilder: (context, index) {
                final chapter = state.mathChapters[index];
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
                            value: _mathChapterBloc,
                            child: ChapterDetailScreen(chapter: chapter),
                          ),
                        ),
                      );
                      _mathChapterBloc.add(LoadMathChaptersEvent());
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
            _firestore.collection('Math Chapter').doc(chapterName);
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
    _mathChapterBloc.close();
    super.dispose();
  }
}
