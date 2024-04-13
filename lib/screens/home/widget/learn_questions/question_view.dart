import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learnjava/data/model/body/progress_model.dart';
import 'package:learnjava/data/model/response/config_model.dart';
import 'package:learnjava/localization/language_constrants.dart';
import 'package:learnjava/providers/profile_provider.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:provider/provider.dart';

import '../../../../providers/splash_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../dashboard/dashboard_screen.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key,this.level,this.online});
  final dynamic level;
  final bool? online;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  int? currentQuestionIndex;
  List<Questions>? questions;
  List<int>? groupvalue=[4];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupvalue=[-1,-1,-1,-1];
    questions=widget.level!.questions;
    currentQuestionIndex=questions![0].id!-1;
  }
// int selected=-1;
//   int selected1=-1;
//   int selected2=-1;
//   int selected3=-1;

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [SizedBox(
        width: double.infinity,
        height:MediaQuery.of(context).size.height*0.6,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                questions![currentQuestionIndex!%4].text??"",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  RadioListTile(
                    title: Text(questions![currentQuestionIndex!%4].answer1??""),
                    value: 1,
                    groupValue:groupvalue![questions!.indexOf(questions![ currentQuestionIndex!%4])],
                    onChanged: (value) {
                      setState(() {
                        groupvalue![questions!.indexOf(questions![ currentQuestionIndex!%4])]=value!;
                      });
                    },
                  ), RadioListTile(
                    title: Text(questions![currentQuestionIndex!%4].answer2??""),
                    value: 2,
                    groupValue:groupvalue![questions!.indexOf(questions![ currentQuestionIndex!%4])],
                    onChanged: (value) {
                      setState(() {
                        groupvalue![questions!.indexOf(questions![ currentQuestionIndex!%4])]=value!;
                      });
                    },
                  ), RadioListTile(
                    title: Text(questions![currentQuestionIndex!%4].answer3??""),
                    value: 3,
                    groupValue:groupvalue![questions!.indexOf(questions![ currentQuestionIndex!%4])],
                    onChanged: (value) {
                      setState(() {
                        groupvalue![questions!.indexOf(questions![ currentQuestionIndex!%4])]=value!;
                      });
                    },
                  ), RadioListTile(
                    title: Text(questions![currentQuestionIndex!%4].answer4??""),
                    value: 4,
                    groupValue: groupvalue![questions!.indexOf(questions![ currentQuestionIndex!%4])],
                    onChanged: (value) {
                      setState(() {
                        groupvalue![questions!.indexOf(questions![ currentQuestionIndex!%4])]=value!;
                      });
                    },
                  ),
                ]
              ),
              SizedBox(height: 50),
          
            ],
          
          ),
        ),
      ),
    Positioned(
    bottom: 10.0, // Adjust padding from bottom
    left: 0.0,
    right: 0.0,
    child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentQuestionIndex!%4 ==0?
            SizedBox():
            ElevatedButton(
              onPressed: () {
                if (currentQuestionIndex!%4 >0) {
                  setState(() {
                    currentQuestionIndex=currentQuestionIndex!%4-1;
                  });
                }
              },
              child: Text(getTranslated("prev", context)??"Prev"),
            ),
            ElevatedButton(
              onPressed: () {
                ProgressModel progress=ProgressModel();
                progress.level_id=widget.level!.id;
                progress.q1=groupvalue![0];
                progress.q2=groupvalue![1];
                progress.q3=groupvalue![2];
                progress.q4=groupvalue![3];
                if (groupvalue![currentQuestionIndex!%4] != -1) {
                  if (currentQuestionIndex!%4 < questions!.length - 1) {
                    setState(() {
                      //Provider.of<ProfileProvider>(context,listen: false).setUserPoints();
                      currentQuestionIndex=currentQuestionIndex!%4+1;
                    });
                  } else {

                    final correctAnswers = widget.level!.questions!
                        .map<int>((question) => int.parse(question.correctAnswer!))
                        .toList();
                    final userAnswers = [progress.q1,progress.q2,progress.q3,progress.q4];
                    final pointsPerAnswer =int.parse(widget.level!.points.toString());

                    // Calculate the total score
                    final totalScore = userAnswers.asMap().entries.fold<int>(
                      0,
                          (score, entry) {
                        final userAnswer = entry.value;
                        final correctAnswer = correctAnswers[entry.key];
                        return score + (userAnswer == correctAnswer ? pointsPerAnswer : 0);
                      },
                    );
                    progress.points=totalScore;
                    setState(() {

                    });
                     Provider.of<ProfileProvider>(context,listen: false).setUserPoints(progress,route);

                  }
                } else {
                  // Show error message if no answer is selected
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(getTranslated("Please select an answer!", context)??'Please select an answer!'),
                  ));
                }
              },
              child:currentQuestionIndex!%4 == questions!.length - 1?
              Provider.of<ProfileProvider>(context, listen: true).isLoading?
              const SizedBox(
                width: 20,height: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      ColorResources.primaryColor,
                    ),
                  ),
                ),
              ):
              Text(getTranslated("Submit", context)??"Submit"):Text(getTranslated("Next", context)??"Next"),
            ),
          ],
        )),
      ],
    );
  }

  Future<void> route(bool done,String message) async {
      if (done){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(message!, context) ?? message), backgroundColor: ColorResources.primaryOrangeColor));
        await Provider.of<SplashProvider>(context, listen: false).initConfig(context).then((bool isSuccess) {
        if(isSuccess) {
          if(int.parse(Provider.of<SplashProvider>(context, listen: false).configModel!.data!.user!.total_points!.toString())>=int.parse(Provider.of<SplashProvider>(context, listen: false).configModel!.data!.pointsToOnline!.toString())&&
              Provider.of<SplashProvider>(context, listen: false).showIntro()!
          ){
            Provider.of<SplashProvider>(context, listen: false).splashRepo!.disableIntro();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(getTranslated("onlineTime", context)??"Online Time"),
                  content: Text('${getTranslated("congra", context) ?? "Congratulations!!\n You Have Erned"} ${Provider.of<SplashProvider>(context, listen: false).configModel!.data!.pointsToOnline!} \n ${getTranslated("goOnline", context) ?? "Go Now You Can Play Online With your Friends"}'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  DashBoardScreen(index:1)));
                      },
                      child: Text(getTranslated("ok", context)??'OK'),
                    ),
                  ],
                );
              },
            );
          }
else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  DashBoardScreen(index:( widget.online??false)?1:0,)));

          }
        }});
      } else  {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(message!, context) ?? message), backgroundColor: ColorResources.primaryOrangeColor));

      }
  }
}
