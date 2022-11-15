import 'package:flutter/material.dart';
import 'package:hybrid/activity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? welcome;
  List<String>? activities;
  @override
  void initState() {
    super.initState();
    _getWelcome();
    _getActivity();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getWelcome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String returnName = prefs.getString("name") ?? '';
    setState(() {
      welcome = "Hi, " + returnName + " !";
    });
  }

  _getActivity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final listOf = setState(() {
      activities = prefs.getStringList('activities');
      activities!.removeWhere((el) => el.isEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List bulan = [
      "Januari",
      "Fabruari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                welcome ?? '',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text(
                'Activity Done',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            activities == null || activities!.length == 0
                ? Container()
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(activities![index],
                                style: TextStyle(fontSize: 24)),
                          ),
                        );
                      },
                      itemCount: activities!.length,
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (contenxt) => ActivityPage()));
        },
        tooltip: 'Tambah Aktifitas',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}
