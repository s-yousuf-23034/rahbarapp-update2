import 'package:flutter_test/flutter_test.dart';
import 'package:rahbarapp/login/Login.dart';
import 'package:rahbarapp/widgets/textformfield.dart';

void main() {
  testWidgets('Login Widget Test', (WidgetTester tester) async {
    // Build the Login widget
    await tester.pumpWidget(Login());

    // Verify that the widgets are rendered correctly
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Perform actions and test the behavior
    await tester.enterText(find.byType(MyTextField).first, 'test@example.com');
    await tester.enterText(find.byType(MyTextField).last, 'password');
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verify the expected result after the actions
    expect(find.text('Loading'), findsOneWidget);
    // You can add more assertions based on the expected behavior of the widget
  });
}





// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:rahbarapp/math_chapter/bloc/mathchapter_bloc.dart';
// import 'package:rahbarapp/math_chapter/bloc/mathchapter_state.dart';
// import 'package:rahbarapp/math_chapter/chapter_detail_screen.dart';
// import 'package:rahbarapp/math_chapter/math_chapterlist_screen.dart';
// import 'package:rahbarapp/model/math_chapter.dart';


// // Mock FirebaseAuth
// class MockFirebaseAuth extends Mock implements FirebaseAuth {}

// // Mock FirebaseFirestore
// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// void main() {
//   group('MathChapterListScreen', () {
//     late MockFirebaseAuth mockFirebaseAuth;
//     late MockFirebaseFirestore mockFirebaseFirestore;

//     setUp(() {
//       mockFirebaseAuth = MockFirebaseAuth();
//       mockFirebaseFirestore = MockFirebaseFirestore();
//     });

//     testWidgets('Should show CircularProgressIndicator when loading state',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(
//         home: MathChapterListScreen(),
//       ));

//       final circularProgressIndicatorFinder =
//           find.byType(CircularProgressIndicator);

//       expect(circularProgressIndicatorFinder, findsOneWidget);
//     });

//     testWidgets('Should show chapter list when loaded state',
//         (WidgetTester tester) async {
//       // Mock the loaded state
//       final mathChapters = [
//         MathChapter(name: 'Chapter 1', quizAttempted: true, videoUrl: ''),
//         MathChapter(name: 'Chapter 2', quizAttempted: false, videoUrl: ''),
//       ];
//       final loadedState = MathChapterLoadedState(mathChapters: mathChapters);
//       final bloc = MockMathChapterBloc();
//       when(bloc.state).thenReturn(loadedState);

//       await tester.pumpWidget(MaterialApp(
//         home: BlocProvider<MathChapterBloc>.value(
//           value: bloc,
//           child: MathChapterListScreen(),
//         ),
//       ));

//       final chapter1Finder = find.text('Chapter 1');
//       final chapter2Finder = find.text('Chapter 2');

//       expect(chapter1Finder, findsOneWidget);
//       expect(chapter2Finder, findsOneWidget);
//     });

//     testWidgets('Should navigate to ChapterDetailScreen on chapter tap',
//         (WidgetTester tester) async {
//       // Mock the loaded state
//       final mathChapters = [
//         MathChapter(name: 'Chapter 1', quizAttempted: true, videoUrl: ''),
//       ];
//       final loadedState = MathChapterLoadedState(mathChapters: mathChapters);
//       final bloc = MockMathChapterBloc();
//       when(bloc.state).thenReturn(loadedState);

//       await tester.pumpWidget(MaterialApp(
//         home: BlocProvider<MathChapterBloc>.value(
//           value: bloc,
//           child: MathChapterListScreen(),
//         ),
//       ));

//       final chapterFinder = find.text('Chapter 1');
//       await tester.tap(chapterFinder);
//       await tester.pumpAndSettle();

//       // Verify navigation
//       expect(find.byType(ChapterDetailScreen), findsOneWidget);
//     });
//   });
// }
