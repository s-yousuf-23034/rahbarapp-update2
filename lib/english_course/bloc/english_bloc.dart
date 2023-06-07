import 'package:bloc/bloc.dart';
import 'package:rahbarapp/english_course/bloc/english_event.dart';
import 'package:rahbarapp/english_course/bloc/english_state.dart';
import 'package:rahbarapp/model/english_chapter.dart';

class EnglishChapterBloc
    extends Bloc<EnglishChapterEvent, EnglishChapterState> {
  List<EnglishChapter> englishChapters = [];
  EnglishChapterBloc() : super(EnglishChapterLoadingState()) {
    on<LoadEnglishChaptersEvent>(_loadEnglishChapters);
    on<LoadEnglishChapterDetailsEvent>(_loadEnglishChapterDetails);
  }

  void _loadEnglishChapters(
      LoadEnglishChaptersEvent event, Emitter<EnglishChapterState> emit) async {
    emit(EnglishChapterLoadingState());

    // Simulating the loading of data
    await Future.delayed(Duration(seconds: 2));

    try {
      // Static data for the math chapters
      englishChapters = [
        EnglishChapter(
          name: 'Tenses',
          videoUrl: 'https://www.youtube.com/watch?v=3lI3R9_Z1HY',
          quizAttempted: false,
        ),
        EnglishChapter(
          name: 'Parts of Speech',
          videoUrl:
              'https://youtu.be/kP_VkuB08qY?list=PLmwr9polMHwsQmAjoAxtFvwk_PaqQeS68',
          quizAttempted: false,
        ),
        EnglishChapter(
          name: 'Articles',
          videoUrl: 'https://www.youtube.com/watch?v=-zZau_dttRY',
          quizAttempted: false,
        ),
        EnglishChapter(
            name: 'Preposition',
            videoUrl: 'https://www.youtube.com/watch?v=92XBCRYZ1S8',
            quizAttempted: false),
        EnglishChapter(
          name: 'Actives and Passive Voice',
          videoUrl: 'https://www.youtube.com/watch?v=o5vs1YOMQlQ',
          quizAttempted: false,
        ),
        EnglishChapter(
          name: 'Subject-Verb-Agreement',
          videoUrl: 'https://www.youtube.com/watch?v=5vcNs1BDTJ0',
          quizAttempted: false,
        ),
        EnglishChapter(
          name: 'Clauses and Phrase',
          videoUrl: 'https://www.youtube.com/watch?v=xyq9eJn9W0Q',
          quizAttempted: false,
        ),
        EnglishChapter(
          name: 'Vocabulary-1',
          videoUrl: 'https://www.youtube.com/watch?v=kQemoGlKI14',
          quizAttempted: false,
        ),
        EnglishChapter(
          name: 'Vocabulary-2',
          videoUrl: 'https://www.youtube.com/watch?v=EG6fJ9vD_n0',
          quizAttempted: false,
        ),
        EnglishChapter(
          name: 'Vocabulary-3',
          videoUrl: 'https://www.youtube.com/watch?v=f1MZBLAaFCU',
          quizAttempted: false,
        ),
      ];

      emit(EnglishChapterLoadedState(englishChapters));
    } catch (e) {
      emit(EnglishChapterErrorState('Error loading chapters.'));
    }
  }

  void _loadEnglishChapterDetails(LoadEnglishChapterDetailsEvent event,
      Emitter<EnglishChapterState> emit) async {
    emit(EnglishChapterLoadingState());

    try {
      EnglishChapter? chapter = await _fetchChapterDetails(event.chapterName);

      if (chapter != null) {
        // print("chapter not null ${chapter.videoUrl}");
        emit(EnglishChapterLoadedState([chapter], chap: chapter));
      } else {
        emit(EnglishChapterErrorState('Chapter not found.'));
      }
    } catch (e) {
      emit(EnglishChapterErrorState('Error loading chapter details.'));
    }
  }

  _fetchChapterDetails(String chapterName) async {
    List<EnglishChapter> englishChapters = [
      EnglishChapter(
        name: 'Tenses',
        videoUrl: 'https://www.youtube.com/watch?v=3lI3R9_Z1HY',
        quizAttempted: false,
      ),
      EnglishChapter(
        name: 'Parts of Speech',
        videoUrl:
            'https://youtu.be/kP_VkuB08qY?list=PLmwr9polMHwsQmAjoAxtFvwk_PaqQeS68',
        quizAttempted: false,
      ),
      EnglishChapter(
        name: 'Articles',
        videoUrl: 'https://www.youtube.com/watch?v=-zZau_dttRY',
        quizAttempted: false,
      ),
      EnglishChapter(
          name: 'Preposition',
          videoUrl: 'https://www.youtube.com/watch?v=92XBCRYZ1S8',
          quizAttempted: false),
      EnglishChapter(
        name: 'Actives and Passive Voice',
        videoUrl: 'https://www.youtube.com/watch?v=o5vs1YOMQlQ',
        quizAttempted: false,
      ),
      EnglishChapter(
        name: 'Subject-Verb-Agreement',
        videoUrl: 'https://www.youtube.com/watch?v=5vcNs1BDTJ0',
        quizAttempted: false,
      ),
      EnglishChapter(
        name: 'Clauses and Phrase',
        videoUrl: 'https://www.youtube.com/watch?v=xyq9eJn9W0Q',
        quizAttempted: false,
      ),
      EnglishChapter(
        name: 'Vocabulary-1',
        videoUrl: 'https://www.youtube.com/watch?v=kQemoGlKI14',
        quizAttempted: false,
      ),
      EnglishChapter(
        name: 'Vocabulary-2',
        videoUrl: 'https://www.youtube.com/watch?v=EG6fJ9vD_n0',
        quizAttempted: false,
      ),
      EnglishChapter(
        name: 'Vocabulary-3',
        videoUrl: 'https://www.youtube.com/watch?v=f1MZBLAaFCU',
        quizAttempted: false,
      ),
    ];
    EnglishChapter? chapter;
    try {
      for (var element in englishChapters) {
        if (element.name == chapterName) {
          chapter = element;
          break;
        }
      }
    } catch (e) {
      // Chapter not found
      chapter = null;
    }
    // print(chapter?.name);
    return chapter;
  }
}
