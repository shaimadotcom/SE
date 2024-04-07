import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnjava/providers/profile_provider.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../../data/model/body/QuestionModel.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  QuestionModel questions=QuestionModel.fromJson({
    "questions":[
      {
        "question": "What is Java?",
        "selectedAnswerIndex":-1,
        "answers": [
          {
            "id": 1,
            "answer": "A Programing language"
          },
          {
            "id": 2,
            "answer": "A game"
          },
          {
            "id": 3,
            "answer": "A robot"
          },
          {
            "id": 4,
            "answer": "A man"
          }
        ]
      },
      {
        "question": "is Java amzing?",
        "selectedAnswerIndex":-1,
        "answers": [
          {
            "id": 1,
            "answer": "yessometimessometimessometimessometimessometimessometimessometimes"
          },
          {
            "id": 2,
            "answer": "nosometimessometimessometimessometimessometimes"
          },
          {
            "id": 3,
            "answer": "maybesometimessometimessometimessometimessometimessometimes"
          },
          {
            "id": 4,
            "answer": "sometimessometimessometimessometimessometimessometimessometimessometimessometimessometimes"
          }
        ]
      },
      {
        "question": "What are the OOPs concepts?",
        "selectedAnswerIndex":-1,
        "answers": [

          {
            "id": 1,
            "answer": "Encapsulation"
          },
          {
            "id": 2,
            "answer": "Polymorphism"
          },
          {
            "id": 3,
            "answer": "Abstraction"
          },
          {
            "id": 4,
            "answer": "Interface"
          }
        ]
      },
      {
        "question": "What is meant by Method Overriding?",
        "selectedAnswerIndex":-1,
        "answers": [
          {
            "id": 1,
            "answer": "Method name should be the same"
          },
          {
            "id": 2,
            "answer": "The argument should not be the same"
          },
          {
            "id": 3,
            "answer": "all above"
          },
          {
            "id": 4,
            "answer": "not of above"
          }
        ]
      }
    ]
  });
  int currentQuestionIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Stack(
      children: [Container(
        width: double.infinity,
        height:MediaQuery.of(context).size.height*0.5,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                questions.questions![currentQuestionIndex].question??"",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Column(
                children: List.generate(
                  questions.questions![currentQuestionIndex].answers?.length??0,
                      (index) => RadioListTile(
                    title: Text(questions.questions![currentQuestionIndex].answers![index].answer??""),
                    value: index,
                    groupValue: questions.questions![currentQuestionIndex].selectedAnswerIndex,
                    onChanged: (value) {
                      setState(() {
                        questions.questions![currentQuestionIndex].selectedAnswerIndex = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 50),
          
            ],
          
          ),
        ),
      ),
    Positioned(
    bottom: 1.0, // Adjust padding from bottom
    left: 0.0,
    right: 0.0,
    child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentQuestionIndex ==0?
            SizedBox():
            ElevatedButton(
              onPressed: () {
                if (currentQuestionIndex >0) {
                  setState(() {
                    currentQuestionIndex--;
                  });
                }
              },
              child: Text('Prev'),
            ),
            ElevatedButton(
              onPressed: () {
                if (questions.questions![currentQuestionIndex].selectedAnswerIndex != -1) {
                  // Move to the next question if available
                  if (currentQuestionIndex < questions.questions!.length - 1) {
                    setState(() {
                      Provider.of<ProfileProvider>(context,listen: false).setUserPoints();
                      currentQuestionIndex++;
                    });
                  } else {
                    Provider.of<ProfileProvider>(context,listen: false).setUserPoints();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Questions Completed'),
                          content: Text('You have completed all questions.\nYou can now play online!!'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  // Show error message if no answer is selected
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select an answer!'),
                  ));
                }
              },
              child:currentQuestionIndex == questions.questions!.length - 1? Text('Submit'):Text('Next'),
            ),
          ],
        )),
      ],
    );
  }}
