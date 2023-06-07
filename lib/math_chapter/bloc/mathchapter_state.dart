import 'package:equatable/equatable.dart';
import 'package:rahbarapp/model/math_chapter.dart';

abstract class MathChapterState extends Equatable {
  const MathChapterState();

  @override
  List<Object?> get props => [];

  get chapter => null;
}

class MathChapterLoadingState extends MathChapterState {}

class MathChapterLoadedState extends MathChapterState {
  final List<MathChapter> mathChapters;
  dynamic chap;
  MathChapterLoadedState(this.mathChapters, {this.chap});

  @override
  List<Object?> get props => [mathChapters];

  get chapter => chap;
}

class MathChapterErrorState extends MathChapterState {
  final String error;

  MathChapterErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
