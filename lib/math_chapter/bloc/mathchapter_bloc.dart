import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rahbarapp/math_chapter/bloc/mathchapter_state.dart';
import 'package:rahbarapp/model/math_chapter.dart';

part 'mathchapter_event.dart';

class MathChapterBloc extends Bloc<MathChapterEvent, MathChapterState> {
  List<MathChapter> mathChapters = [];
  MathChapterBloc() : super(MathChapterLoadingState()) {
    on<LoadMathChaptersEvent>(_loadMathChapters);
    on<LoadMathChapterDetailsEvent>(_loadMathChapterDetails);
  }

  void _loadMathChapters(
      LoadMathChaptersEvent event, Emitter<MathChapterState> emit) async {
    emit(MathChapterLoadingState());

    // Simulating the loading of data
    await Future.delayed(Duration(seconds: 2));

    try {
      // Static data for the math chapters
      mathChapters = [
        MathChapter(
          name: 'Complex Number',
          videoUrl: 'https://www.youtube.com/watch?v=BZxZ_eEuJBM',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Matrices and Determinants',
          videoUrl:
              'https://www.youtube.com/watch?v=3ROzG6n4yMc&pp=ygUZTWF0cmljZXMgYW5kIERldGVybWluYW50cw%3D%3D',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Sequences and Series',
          videoUrl:
              'https://www.youtube.com/watch?v=Tj89FA-d0f8&pp=ygUOc2VxIGFuZCBzZXJpZXM%3D',
          quizAttempted: false,
        ),
        MathChapter(
            name: 'Permutation combination and probability',
            videoUrl:
                'https://www.youtube.com/watch?v=XJnIdRXUi7A&pp=ygUdcGVybXV0YXRpb25zIGFuZCBjb21iaW5hdGlvbnM%3D',
            quizAttempted: false),
        MathChapter(
          name: 'Quadratic Equation',
          videoUrl:
              'https://www.youtube.com/watch?v=qeByhTF8WEw&pp=ygUSUXVhZHJhdGljIGVxdWF0aW9u',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Function and their graph',
          videoUrl:
              'https://www.youtube.com/watch?v=kvU9sOzT2mk&pp=ygUYRnVuY3Rpb24gYW5kIHRoZWlyIGdyYXBo',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Functions and limits',
          videoUrl:
              'https://www.youtube.com/watch?v=YNstP0ESndU&pp=ygUURnVuY3Rpb25zIGFuZCBsaW1pdHM%3D',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Partial Fractions',
          videoUrl:
              'https://www.youtube.com/watch?v=6rXByMcuAyI&pp=ygURUGFydGlhbCBGcmFjdGlvbnM%3D',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Percentages',
          videoUrl:
              'https://www.youtube.com/watch?v=WYWPuG-8U5Q&pp=ygULcGVyY2VudGFnZXM%3D',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Mean, Median, Mode',
          videoUrl:
              'https://www.youtube.com/watch?v=A1mQ9kD-i9I&pp=ygUabWVhbiBtb2RlIG1lZGlhbiBhbmQgcmFuZ2U%3D',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Ratio and Proportion',
          videoUrl:
              'https://www.youtube.com/watch?v=JOZSFwuyqok&pp=ygUUcmF0aW8gYW5kIHByb3BvcnRpb24%3D',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Derivatives',
          videoUrl:
              'https://www.youtube.com/watch?v=5yfh5cf4-0w&pp=ygULZGVyaXZhdGl2ZXM%3D',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Integration',
          videoUrl:
              'https://www.youtube.com/watch?v=o75AqTInKDU&pp=ygULaW50ZWdyYXRpb24%3D',
          quizAttempted: false,
        ),
        MathChapter(
          name: 'Algebra',
          videoUrl:
              'https://www.youtube.com/watch?v=grnP3mduZkM&pp=ygUZYWxnZWJyYSB1bml2ZXJzaXR5IGxldmVsIA%3D%3D',
          quizAttempted: false,
        ),
      ];

      emit(MathChapterLoadedState(mathChapters));
    } catch (e) {
      emit(MathChapterErrorState('Error loading chapters.'));
    }
  }

  void _loadMathChapterDetails(
      LoadMathChapterDetailsEvent event, Emitter<MathChapterState> emit) async {
    emit(MathChapterLoadingState());
    // print("......................function called");

    // Simulating the loading of chapter details
    // await Future.delayed(Duration(seconds: 2));

    try {
      // Retrieve the chapter details based on the provided chapterName
      // print("..............trying:}");

      MathChapter? chapter = await _fetchChapterDetails(event.chapterName);
      // print("..............chapter: ${chapter?.name}");

      if (chapter != null) {
        // print("chapter not null ${chapter.videoUrl}");
        emit(MathChapterLoadedState([chapter], chap: chapter));
      } else {
        emit(MathChapterErrorState('Chapter not found.'));
      }
    } catch (e) {
      emit(MathChapterErrorState('Error loading chapter details.'));
    }
  }

  _fetchChapterDetails(String chapterName) async {
    List<MathChapter> mathChapters = [
      MathChapter(
        name: 'Complex Number',
        videoUrl: 'https://www.youtube.com/watch?v=BZxZ_eEuJBM',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Matrices and Determinants',
        videoUrl:
            'https://www.youtube.com/watch?v=3ROzG6n4yMc&pp=ygUZTWF0cmljZXMgYW5kIERldGVybWluYW50cw%3D%3D',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Sequences and Series',
        videoUrl:
            'https://www.youtube.com/watch?v=Tj89FA-d0f8&pp=ygUOc2VxIGFuZCBzZXJpZXM%3D',
        quizAttempted: false,
      ),
      MathChapter(
          name: 'Permutation combination and probability',
          videoUrl:
              'https://www.youtube.com/watch?v=XJnIdRXUi7A&pp=ygUdcGVybXV0YXRpb25zIGFuZCBjb21iaW5hdGlvbnM%3D',
          quizAttempted: false),
      MathChapter(
        name: 'Quadratic Equation',
        videoUrl:
            'https://www.youtube.com/watch?v=qeByhTF8WEw&pp=ygUSUXVhZHJhdGljIGVxdWF0aW9u',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Function and their graph',
        videoUrl:
            'https://www.youtube.com/watch?v=kvU9sOzT2mk&pp=ygUYRnVuY3Rpb24gYW5kIHRoZWlyIGdyYXBo',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Functions and limits',
        videoUrl:
            'https://www.youtube.com/watch?v=YNstP0ESndU&pp=ygUURnVuY3Rpb25zIGFuZCBsaW1pdHM%3D',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Partial Fractions',
        videoUrl:
            'https://www.youtube.com/watch?v=6rXByMcuAyI&pp=ygURUGFydGlhbCBGcmFjdGlvbnM%3D',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Percentages',
        videoUrl:
            'https://www.youtube.com/watch?v=WYWPuG-8U5Q&pp=ygULcGVyY2VudGFnZXM%3D',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Mean, Median, Mode',
        videoUrl:
            'https://www.youtube.com/watch?v=A1mQ9kD-i9I&pp=ygUabWVhbiBtb2RlIG1lZGlhbiBhbmQgcmFuZ2U%3D',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Ratio and Proportion',
        videoUrl:
            'https://www.youtube.com/watch?v=JOZSFwuyqok&pp=ygUUcmF0aW8gYW5kIHByb3BvcnRpb24%3D',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Derivatives',
        videoUrl:
            'https://www.youtube.com/watch?v=5yfh5cf4-0w&pp=ygULZGVyaXZhdGl2ZXM%3D',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Integration',
        videoUrl:
            'https://www.youtube.com/watch?v=o75AqTInKDU&pp=ygULaW50ZWdyYXRpb24%3D',
        quizAttempted: false,
      ),
      MathChapter(
        name: 'Algebra',
        videoUrl:
            'https://www.youtube.com/watch?v=grnP3mduZkM&pp=ygUZYWxnZWJyYSB1bml2ZXJzaXR5IGxldmVsIA%3D%3D',
        quizAttempted: false,
      ),
    ];
    MathChapter? chapter;
    try {
      for (var element in mathChapters) {
        if (element.name == chapterName) {
          chapter = element;
          break;
        }
      }

      // chapter = mathChapters
      //     .firstWhere((mathChapter) => mathChapter.name == chapterName);
    } catch (e) {
      // Chapter not found
      chapter = null;
    }
    // print(chapter?.name);
    return chapter;
  }

  addAsync(LoadMathChapterDetailsEvent loadMathChapterDetailsEvent) {}
}
