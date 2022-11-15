import 'package:flutter/material.dart';
import 'package:hybrid/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  _ActivityPage createState() => _ActivityPage();
}

class _ActivityPage extends State<ActivityPage> {
  TextEditingController activity = TextEditingController();
  String? name;
  @override
  void initState() {
    super.initState();
    _getName();
    _setActivity();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String returnName = prefs.getString("name") ?? '';
    setState(() {
      name = returnName;
    });
  }

  _setActivity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? lastActivity = prefs.getStringList('activities');
    List<String> newActivity = [];
    if (lastActivity == null || lastActivity.length == 0) {
      newActivity.add(activity.text.toString());
      prefs.setStringList('activities', newActivity);
    } else {
      lastActivity.add(activity.text.toString());
      prefs.setStringList('activities', lastActivity);
    }
    print(prefs.getStringList('activities'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Activity Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'What you gonna do ' + name.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: activity,
                maxLines: 5,
                minLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'write you activity here..',
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (activity.text.toString().length != 0) {
                      _setActivity();
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (contenxt) => HomePage()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("All fields should be filled."),
                      ));
                    }
                  },
                  child: Text('Simpan'))
            ],
          ),
        ),
      ),
    ));
  }
}
