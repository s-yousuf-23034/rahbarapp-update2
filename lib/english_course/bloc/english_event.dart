import 'package:equatable/equatable.dart';

abstract class EnglishChapterEvent extends Equatable {
  const EnglishChapterEvent();

  @override
  List<Object?> get props => [];
}

class LoadEnglishChaptersEvent extends EnglishChapterEvent {}

class LoadEnglishChapterDetailsEvent extends EnglishChapterEvent {
  final String chapterName;

  const LoadEnglishChapterDetailsEvent({required this.chapterName});

  @override
  List<Object> get props => [chapterName];
}
