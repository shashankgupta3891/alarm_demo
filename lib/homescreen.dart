import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:alarm_demo/setAlarm.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homes extends StatefulWidget {
  homes({this.alarmtime, this.alarmlabel});
  final alarmtime;
  final alarmlabel;
  @override
  _homesState createState() => _homesState();
}

class _homesState extends State<homes> {
//  AudioPlayer audioPlayer1 = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.alarmtime.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              leading: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    AndroidAlarmManager.cancel(widget.alarmtime[index]);
                    prefs.remove(widget.alarmlabel[index]);
                    widget.alarmlabel.removeAt(index);
                    widget.alarmtime.removeAt(index);
                    setState(() {});
                  }),
              title: Text(
                widget.alarmlabel[index].toString(),
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              subtitle: Text("Time " +
                  widget.alarmtime[index].toString().substring(0, 2) +
                  ":" +
                  "${widget.alarmtime[index].toString().substring(2, 4)}"),
              children: dayList(widget.alarmtime[index].toString().substring(
                    4,
                  )),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => new setAlarm(
                    name: widget.alarmlabel,
                    time: widget.alarmtime,
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<ListTile> dayList(String substring) {
    List<ListTile> days = [];
    print(substring);
    if (substring == "7") {
      return [
        ListTile(
          title: Text("Daily"),
        )
      ];
    } else {
      if (substring.contains("0")) {
        days.add(
          ListTile(
            title: Text("Sunday"),
          ),
        );
      }
      if (substring.contains("1")) {
        days.add(
          ListTile(
            title: Text("Monday"),
          ),
        );
      }
      if (substring.contains("2")) {
        days.add(
          ListTile(
            title: Text("Tuesday"),
          ),
        );
      }
      if (substring.contains("3")) {
        days.add(
          ListTile(
            title: Text("Wednesday"),
          ),
        );
      }
      if (substring.contains("4")) {
        days.add(
          ListTile(
            title: Text("Thursday"),
          ),
        );
      }
      if (substring.contains("5")) {
        days.add(
          ListTile(
            title: Text("Friday"),
          ),
        );
      }
      if (substring.contains("6")) {
        days.add(
          ListTile(
            title: Text("Saturday"),
          ),
        );
      } else {
        return [
          ListTile(
            title: Text("hello"),
          )
        ];
      }
      return days;
    }
  }
}
