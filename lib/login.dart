import 'package:flutter/material.dart';
import 'package:hybrid/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  TextEditingController email = TextEditingController();
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
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                    SharedPreferences prefs = await _prefs;
                    print("tag-login: button login pressed. ");
                    print("tag-login: button login pressed. " +
                        email.text.toString() +
                        " - " +
                        password.text.toString());
                    if (email.text.trim().toString().length == 0 || password.text.trim().toString().length == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("email & password should be filled."),
                      ));
                    } else if (prefs.getString("email") ==
                            email.text.trim().toLowerCase().toString() &&
                        prefs.getString("password") ==
                            password.text.trim().toString()) {
                              print("tag-login: button login pressed. email & password match.");
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Login success"),
                              ));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                            } else {
                              print("tag-login: button login pressed. email & password not match.");
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("user is not registered yet."),
                              ));
                            }
                  },
                  child: Text('Login'))
            ],
          ),
        ),
      ),
    ));
  }
}
