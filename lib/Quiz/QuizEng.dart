import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rahbarapp/Zoom/ZoomClass.dart';


class QuizEng extends StatefulWidget {
  @override
  _QuizEngState createState() => _QuizEngState();
}

class _QuizEngState extends State<QuizEng> {
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  List<int?> selectedOptions = [];
  bool quizCompleted = false;

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('questions').get();

    setState(() {
      questions = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        data['options'] = List<String>.from(data['options']);
        return data;
      }).toList();

      selectedOptions = List<int?>.filled(questions.length, null);
    });
  }

  void answerQuestion(int? selectedIndex) {
    setState(() {
      selectedOptions[currentQuestionIndex] = selectedIndex;
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        quizCompleted = true;
      }
    });
  }

  void submitQuiz() {
    int totalQuestions = questions.length;
    int correctAnswers = 0;

    // Compare selected options with admin answers
    for (int i = 0; i < totalQuestions; i++) {
      if (selectedOptions[i] != null &&
          questions[i]['answer'] != null &&
          selectedOptions[i] == int.parse(questions[i]['answer'])) {
        correctAnswers++;
      }
    }

    double score = (correctAnswers / totalQuestions) * 100;

    // Display popup message based on the score
    String message;
    if (score >= 80) {
      message = 'Congratulations! You are good to go for the next lessons.';
    } else {
      message = 'You need to review this lesson again.';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text('Your score: ${score.toStringAsFixed(2)}%\n$message'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Navigate to the CourseListPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ZoomClass()),
                );
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Screen'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Map<String, dynamic> currentQuestion = questions[currentQuestionIndex];
    String questionText = currentQuestion['question'];
    List<String> options = currentQuestion['options'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              questionText,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              children: options.asMap().entries.map((entry) {
                int optionIndex = entry.key;
                String optionText = entry.value;

                return ListTile(
                  title: Text(optionText),
                  leading: Radio<int>(
                    value: optionIndex,
                    groupValue: selectedOptions.length > currentQuestionIndex
                        ? selectedOptions[currentQuestionIndex]
                        : null,
                    onChanged: (int? value) {
                      answerQuestion(value);
                    },
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (quizCompleted) {
                  submitQuiz();
                } else {
                  nextQuestion();
                }
              },
              child: Text(quizCompleted ? 'Submit' : 'Next Question'),
            ),
          ],
        ),
      ),
    );
  }
}
