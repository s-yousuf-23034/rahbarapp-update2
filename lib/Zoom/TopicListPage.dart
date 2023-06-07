import 'package:flutter/material.dart';
import 'package:rahbarapp/Course/Course.dart';
import 'package:rahbarapp/Quiz/QuizEng.dart';

class TopicListPage extends StatelessWidget {
  final Course course;
  List<Map<String, dynamic>> questions = [];
  List<int> userAnswers = [];

  TopicListPage({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Topic List Page for ${course.title}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizEng(
                  )),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => QuizScreen(questions: questions),
                //   ),
                // );
              },
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
