class EnglishChapter {
  final String name;
  final String videoUrl;
  bool quizAttempted;

  EnglishChapter({
    required this.name,
    required this.videoUrl,
    this.quizAttempted = false,
  });
}
