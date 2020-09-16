import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:fitness_provider/constants.dart';

class HorizontalProgress extends StatelessWidget {
  final double percentage;
  HorizontalProgress({this.percentage});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      margin: EdgeInsets.only(left: 10.0),
      child: new LinearPercentIndicator(
        width: MediaQuery.of(context).size.width - 100,
        lineHeight: 14.0,
        percent: percentage,
        center: Text(
          "50.0%",
          style: new TextStyle(color: Color(0xFFE0E0E0), fontSize: 12.0),
        ),
        linearStrokeCap: LinearStrokeCap.roundAll,
        backgroundColor: Color(0xFFE0E0E0),
        progressColor: kLightThemeColor,
      ),
    );
  }
}
