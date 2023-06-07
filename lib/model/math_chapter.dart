class MathChapter {
  final String name;
  final String videoUrl;
  bool quizAttempted;

  MathChapter({
    required this.name,
    required this.videoUrl,
    this.quizAttempted = false,
  });
}
