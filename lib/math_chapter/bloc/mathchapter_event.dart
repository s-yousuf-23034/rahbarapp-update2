part of 'mathchapter_bloc.dart';

abstract class MathChapterEvent extends Equatable {
  const MathChapterEvent();

  @override
  List<Object?> get props => [];
}

class LoadMathChaptersEvent extends MathChapterEvent {}

class LoadMathChapterDetailsEvent extends MathChapterEvent {
  final String chapterName;

  const LoadMathChapterDetailsEvent({required this.chapterName});

  @override
  List<Object> get props => [chapterName];
}
