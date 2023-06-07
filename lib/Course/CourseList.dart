import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahbarapp/Course/bloc/CouseListBloc.dart';
import 'package:rahbarapp/Course/bloc/CourseState.dart';
import 'package:rahbarapp/Zoom/TopicListPage.dart';
import 'package:rahbarapp/english_course/english_chapterlist.dart';
import 'package:rahbarapp/math_chapter/math_chapterlist_screen.dart';
import 'package:rahbarapp/pages/FAQs.dart';
import 'package:rahbarapp/widgets/button.dart';
import 'package:rahbarapp/widgets/drawer.dart';

class CourseList extends StatelessWidget {
  final CourseListBloc _courseListBloc = CourseListBloc();
  final String username;
  final bool isAdmin;

  CourseList({required this.username, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    _courseListBloc.add(FetchCoursesEvent());

    return BlocProvider<CourseListBloc>.value(
      value: _courseListBloc,
      child: Container(
        color: Colors.amber,
        child: Scaffold(
          appBar: AppBar(
            title: Text('CourseList'),
            backgroundColor: Color.fromARGB(255, 60, 5, 69),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          drawer: AppDrawer(
            username: username,
            isAdmin: isAdmin,
          ),
          body: BlocBuilder<CourseListBloc, CourseState>(
            builder: (context, state) {
              if (state is CourseLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CourseLoadedState) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // Adjust the crossAxisCount as needed
                      childAspectRatio:
                          1.5, // Adjust the aspect ratio as needed
                    ),
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      final course = state.courses[index];
                      return Container(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        course.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        course.description,
                                      ),
                                      SizedBox(height: 8.0),
                                      LinearProgressIndicator(
                                        value: course.progress / 100,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Image.asset(
                                          course.image,
                                          fit: BoxFit.cover,
                                          // width: 500,
                                          // height: 500,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Navigate to TopicListPage
                                          if (course.title == 'Maths') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MathChapterListScreen(),
                                              ),
                                            );
                                          } else if (course.title ==
                                              'English') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EnglishChapterListScreen(),
                                              ),
                                            );
                                          } else if (course.title ==
                                              'Mock Test') {
                                            print('Mock Test');
                                          }
                                        },
                                        child: Text('Go to ${course.title}'),
                                      ),
                                      if (isAdmin) SizedBox(height: 8.0),
                                      if (isAdmin)
                                        ElevatedButton(
                                          onPressed: () {
                                            // Navigate to FAQsScreen
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FAQsScreen(
                                                  username: username,
                                                  isAdmin: isAdmin,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text('FAQs'),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is CourseErrorState) {
                return Center(child: Text('Failed to load courses.'));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
