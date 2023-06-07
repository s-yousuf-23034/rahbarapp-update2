import 'package:equatable/equatable.dart';
import 'package:rahbarapp/model/english_chapter.dart';

abstract class EnglishChapterState extends Equatable {
  const EnglishChapterState();

  @override
  List<Object?> get props => [];

  get chapter => null;
}

class EnglishChapterLoadingState extends EnglishChapterState {}

class EnglishChapterLoadedState extends EnglishChapterState {
  final List<EnglishChapter> englishChapters;
  dynamic chap;
  EnglishChapterLoadedState(this.englishChapters, {this.chap});

  @override
  List<Object?> get props => [englishChapters];

  get chapter => chap;
}

class EnglishChapterErrorState extends EnglishChapterState {
  final String error;

  EnglishChapterErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
