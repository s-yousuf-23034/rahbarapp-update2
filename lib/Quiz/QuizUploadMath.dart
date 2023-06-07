import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizUploadMath extends StatefulWidget {
  final String userName;

  const QuizUploadMath({Key? key, required this.userName}) : super(key: key);

  @override
  _QuizUploadMathState createState() => _QuizUploadMathState();
}

class _QuizUploadMathState extends State<QuizUploadMath>
    with AutomaticKeepAliveClientMixin<QuizUploadMath> {
  List<Map<String, dynamic>> questions = [];
  final questionController = TextEditingController();
  final optionControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  int selectedOptionIndex = 0;
  int editingIndex = -1;

  @override
  bool get wantKeepAlive => true;

  Future<List<Map<String, dynamic>>> getQuestions() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('questions').get();

    List<Map<String, dynamic>> results = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      data['id'] = doc.id;
      return data;
    }).toList();

    return results;
  }

  Future<void> addQuestion(Map<String, dynamic> question) async {
    await FirebaseFirestore.instance.collection('questions').add(question);
    setState(() {
      questionController.clear();
      optionControllers.forEach((controller) => controller.clear());
      selectedOptionIndex = 0;
    });
  }

  Future<void> updateQuestion(Map<String, dynamic> question) async {
    String id = question['id'];
    await FirebaseFirestore.instance
        .collection('questions')
        .doc(id)
        .update(question);

    setState(() {
      questionController.clear();
      optionControllers.forEach((controller) => controller.clear());
      selectedOptionIndex = 0;
      editingIndex = -1;
    });
  }

  Future<void> deleteQuestion(String id) async {
    await FirebaseFirestore.instance.collection('questions').doc(id).delete();
    setState(() {});
  }

  void editQuestion(Map<String, dynamic> question) {
    setState(() {
      questionController.text = question['question'];
      optionControllers.asMap().forEach((i, controller) {
        controller.text = question['options'][i];
      });
      selectedOptionIndex = question['answerIndex'];
      editingIndex = questions.indexOf(question);
    });
  }

  @override
  void dispose() {
    questionController.dispose();
    optionControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: getQuestions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        questions = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Quiz Upload',
              style: TextStyle(
                color: Colors.white, // Set app bar text color to white
              ),
            ),
            backgroundColor: Colors.amber, // Set app bar color to amber
          ),
          backgroundColor: Color.fromARGB(255, 60, 5, 69),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: questionController,
                      decoration: InputDecoration(
                        labelText: 'Question',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Options',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Column(
                      children: optionControllers
                          .asMap()
                          .map(
                            (index, controller) => MapEntry(
                              index,
                              TextField(
                                controller: controller,
                                decoration: InputDecoration(
                                  labelText: 'Option ${index + 1}',
                                  labelStyle: TextStyle(color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .values
                          .toList(),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Answer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 8.0),
                    DropdownButton<int>(
                      value: selectedOptionIndex,
                      items: optionControllers
                          .asMap()
                          .map(
                            (index, controller) => MapEntry(
                              index,
                              DropdownMenuItem<int>(
                                value: index,
                                child: Text(
                                  controller.text,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )
                          .values
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedOptionIndex = value!;
                        });
                      },
                      dropdownColor:
                          Colors.amber, // Set dropdown color to purple
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (questionController.text.isEmpty) {
                              // Show missing question dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Missing Question'),
                                  content: Text('Please provide a question.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            bool hasEmptyOption = optionControllers
                                .any((controller) => controller.text.isEmpty);
                            if (hasEmptyOption) {
                              // Show missing options dialog
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Missing Options'),
                                  content: Text('Please provide all options.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                              return;
                            }

                            Map<String, dynamic> question = {
                              'question': questionController.text,
                              'options': optionControllers
                                  .map((controller) => controller.text)
                                  .toList(),
                              'answerIndex': selectedOptionIndex,
                            };

                            if (editingIndex == -1) {
                              addQuestion(question);
                            } else {
                              question['id'] = questions[editingIndex]['id'];
                              updateQuestion(question);
                              editingIndex = -1;
                            }

                            questionController.clear();
                            optionControllers
                                .forEach((controller) => controller.clear());
                            selectedOptionIndex = 0;
                          },
                          child: Text('Add Question'),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            questionController.clear();
                            optionControllers
                                .forEach((controller) => controller.clear());
                            selectedOptionIndex = 0;
                            editingIndex = -1;
                          },
                          child: Text('Clear'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey, // Set button color to grey
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Questions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> question = questions[index];
                        return ListTile(
                          title: Text(
                            question['question'],
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Answer: ${question['options'][question['answerIndex']]}',
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  editQuestion(question);
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.amber, // Set icon color to amber
                              ),
                              IconButton(
                                onPressed: () {
                                  deleteQuestion(question['id']);
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red, // Set icon color to red
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
