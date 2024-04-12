import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:learnjava/screens/home/widget/learn_questions/question_view.dart';
import 'package:provider/provider.dart';

import '../../../../utill/color_resources.dart';
import '../../../../utill/dimensions.dart';

class LearnWidget extends StatefulWidget {
  LearnWidget({super.key, this.index});
  final int? index;

  @override
  State<LearnWidget> createState() => _LearnWidgetState();
}

class _LearnWidgetState extends State<LearnWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return
      // Consumer<TripsProvider>(
      //   builder: (context, trip, child) =>
            Container(
              width: double.infinity,
             //height:MediaQuery.of(context).size.height,
              color: ColorResources.pagecolor,
              child: Column(
                children: [
                  //SelectSrcDstWidget(),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  QuestionView()
                ],
              ),
            //)
    );
  }
}
