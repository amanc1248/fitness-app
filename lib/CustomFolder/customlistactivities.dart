import 'package:fitness_provider/Provider/alldata.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomActivities extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    var activitydetails = Provider.of<FitnessData>(context).selectedEvents;

    return SingleChildScrollView(
      child: Container(
          height: 170,
          child: ListView.builder(
            itemCount: activitydetails.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, i) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 60,
                            width: 60,
                            // padding: EdgeInsets.all(18.0),
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(10.0)),
                            // child: Icon(
                            //   // activitydetails[i].icon,
                              
                            //   size: 30,
                            // ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        //  Text(activitydetails[i].date == displayDate?activitydetails[i].activity : ''),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(activitydetails[i].activity),
                            // Text(activity),
                            Text(activitydetails[i].subactivity),
                            // Text(subactivity),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(activitydetails[i].time),
                  // Text(time),
                ],
              );
            },
          )),
    );
  }
}
