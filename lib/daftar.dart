import 'package:flutter/material.dart';
import 'package:hybrid/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({Key? key}) : super(key: key);

  @override
  _DaftarPage createState() => _DaftarPage();
}

class _DaftarPage extends State<DaftarPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Daftar Page'),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                        controller: name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        controller: email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Email',
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                        controller: password,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Password',
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (email.text.trim().toString().length == 0 ||
                              password.text.trim().toString().length == 0 || name.text.toString().length == 0) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text("All fields should be filled."),
                            ));
                          } else {
                            SharedPreferences prefs = await _prefs;
                            print("tag-login: button daftar pressed. ");
                            print("tag-login: button daftar pressed. " +
                                email.text.toString() +
                                " - " +
                                password.text.toString());

                            // set email & password for login
                            prefs.setString("email",
                                email.text.trim().toLowerCase().toString());
                            prefs.setString(
                                "password", password.text.trim().toString());
                            prefs.setString("name", name.text.toString());

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                        },
                        child: Text('Daftar'))
                  ],
                ),
              ),
            )));
  }
}
