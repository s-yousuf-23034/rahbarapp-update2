import 'package:flutter/material.dart';
import 'package:rahbarapp/login/Login.dart';
import 'package:rahbarapp/math_chapter/math_chapterlist_screen.dart';
import 'package:rahbarapp/widgets/button.dart';

class CourseList extends StatefulWidget {
  const CourseList({super.key});

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("You have sucessfully loggedin or Signed In"),
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              icon: Icon(Icons.arrow_back),
            )),
        body: Column(
          children: [
            Text('Course list'),
            const SizedBox(
              height: 20.0,
            ),
            MyButton(
              buttonName: "Math Course",
              color: Color.fromRGBO(85, 24, 93, 9),
              textcolor: Colors.white,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MathChapterListScreen()));
              },
            ),
          ],
        ));
  }
}
