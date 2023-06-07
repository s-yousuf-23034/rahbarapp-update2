import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rahbarapp/Quiz/QuizMath.dart';
import 'package:rahbarapp/math_chapter/bloc/mathchapter_bloc.dart';
import 'package:rahbarapp/math_chapter/bloc/mathchapter_state.dart';
import 'package:rahbarapp/math_chapter/math_chapterlist_screen.dart';
import 'package:rahbarapp/model/math_chapter.dart';
import 'package:rahbarapp/widgets/button.dart';
import 'package:url_launcher/url_launcher.dart';

class ChapterDetailScreen extends StatelessWidget {
  final MathChapter chapter;

  ChapterDetailScreen({required this.chapter});

  @override
  Widget build(BuildContext context) {
    final mathChapterBloc = BlocProvider.of<MathChapterBloc>(context);

    mathChapterBloc.add(LoadMathChapterDetailsEvent(chapterName: chapter.name));

    return FutureBuilder<MathChapter?>(
      future: mathChapterBloc.stream
          .firstWhere((state) => state is MathChapterLoadedState)
          .then((state) => state.chapter),
      builder: (context, snapshot) {
        if (snapshot != null &&
            snapshot.connectionState == ConnectionState.done) {
          final chapter = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text(chapter!.name),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
            ),
            body: BlocBuilder<MathChapterBloc, MathChapterState>(
              bloc: mathChapterBloc,
              builder: (context, state) {
                if (state is MathChapterLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MathChapterLoadedState) {
                  final chapter = state.chapter;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(chapter.name),
                        GestureDetector(
                          onTap: () {
                            launch(chapter.videoUrl);
                          },
                          child: Text(
                            chapter.videoUrl,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        MyButton(
                          buttonName: "Start Quiz",
                          color: Color.fromRGBO(85, 24, 93, 9),
                          textcolor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizMath(),
                              ),
                            );

                            print('Take a Quiz');
                          },
                        ),
                        // Add more widgets to display chapter details
                      ],
                    ),
                  );
                } else if (state is MathChapterErrorState) {
                  return Text(state.error);
                } else {
                  return Text('Failed to load chapter');
                }
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
