import 'package:fitness_provider/Provider/alldata.dart';
import 'package:fitness_provider/Provider/dataconstraint.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AddActivityScreen extends StatefulWidget {
  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  // final _actcontroller = TextEditingController();
  // final _subactcontroller = TextEditingController();
  TextEditingController _actcontroller;
  TextEditingController _subactcontroller;
  DateTime currentdate = DateTime.now();
  TimeOfDay _currenttime = TimeOfDay.now();
  ActivityIcons selecteduser;
  CalendarController _controller;
  FitnessData fitness;
  FitnessDetails fitnessDetails;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _actcontroller = TextEditingController();
    _subactcontroller = TextEditingController();
  }

  Future<Null> _selectdate(BuildContext context) async {
    final DateTime _seldate = await showDatePicker(
      context: context,
      initialDate: currentdate,
      firstDate: currentdate,
      lastDate: currentdate.add(Duration(
        days: 365,
      )),
    );
    if (_seldate != null) {
      setState(() {
        currentdate = _seldate;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay _seltime =
        await showTimePicker(context: context, initialTime: _currenttime);
    if (_seltime != null) {
      setState(() {
        _currenttime = _seltime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final formattedTimeOfDay = localizations.formatTimeOfDay(_currenttime);
    var fitness = Provider.of<FitnessData>(context, listen: false);
    final displayDate = DateFormat.yMMMd().format(currentdate);
    var iconsdetails = Provider.of<FitnessData>(context).icons;
    var theControllerMethod = _controller.selectedDay;
    return Container(
      color: Color(0xff757575),
      height: 410,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add Activity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _actcontroller,
              decoration: new InputDecoration(
                labelText: "Enter your Activity",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  // borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "Activity cannot be empty";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _subactcontroller,
              decoration: new InputDecoration(
                labelText: "Enter your SubActivity",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  // borderSide: new BorderSide(),
                ),
              ),
              validator: (val) {
                if (val.length == 0) {
                  return "SubActivity cannot be empty";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              // width: MediaQuery.of(context).size.width - 40,
              child: DropdownButton<ActivityIcons>(
                hint: Text("Select icon"),
                value: selecteduser,
                onChanged: (ActivityIcons newvalue) {
                  setState(() {
                    selecteduser = newvalue;
                  });
                },
                items: iconsdetails.map<DropdownMenuItem<ActivityIcons>>(
                    (ActivityIcons value) {
                  return DropdownMenuItem<ActivityIcons>(
                    value: value,
                    child: Row(
                      children: <Widget>[
                        value.icon,
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          value.icontitle,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Row(
              children: [
                Text("Date: "),
                FlatButton(
                  child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.lightBlue,
                      child: Text('$displayDate')),
                  onPressed: () {
                    _selectdate(context);
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Time: "),
                FlatButton(
                  child: Container(
                      padding: EdgeInsets.all(8),
                      color: Colors.lightBlue,
                      child: Text('$formattedTimeOfDay')),
                  onPressed: () {
                    _selectTime(context);
                  },
                ),
              ],
            ),
            FlatButton(
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.lightBlueAccent,
                onPressed: () {
                  print("-------------------------------------------");
                  print(fitness.events.length);
                  // print(fitness.events[0][0]);
                  if (fitness.events[_controller.selectedDay] != null) {
                    print(
                        "-----------------------------ssssssssssssssssssssssssssssssss--------------");

                    fitness.addactivity(
                      text: _actcontroller.text,
                      text1: _subactcontroller.text,
                      selectedicon: selecteduser.icon,
                      picktime: formattedTimeOfDay,
                      controller: theControllerMethod,
                    );
                  } else {
                    print(
                        "----------------------sdfjhasjdfhjkashfjkshdfjkhasfd---------------------");

                    fitness.showingTheEvent(
                        activity: _actcontroller.text,
                        subactivity: _subactcontroller.text,
                        icon: selecteduser.icon,
                        time: formattedTimeOfDay,
                        controller: theControllerMethod);
                  }

                  // if (fitnessDetails == null) {
                  //   print("No list");
                  // } else {
                  //   if (fitness.events[_controller.selectedDay] != null) {
                  //     activityadd.addactivity(
                  //         text: _actcontroller.text,
                  //         text1: _subactcontroller.text,
                  //         pickdate: displayDate,
                  //         picktime: formattedTimeOfDay,
                  //         selectedicon: selecteduser.icon,
                  //         controller: theControllerMethod);
                  //   } else {
                  //     activityadd.showingTheEvent(
                  //         activity: _actcontroller.text,
                  //         subactivity: _subactcontroller.text,
                  //         time: formattedTimeOfDay,
                  //         icon: selecteduser.icon,
                  //         controller: theControllerMethod);
                  //   }

                  // activityadd.addactivity(
                  //     text: _actcontroller.text,
                  //     text1: _subactcontroller.text,
                  //     pickdate: displayDate,
                  //     picktime: formattedTimeOfDay,
                  //     selectedicon: selecteduser.icon,
                  //     controller: theControllerMethod);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
