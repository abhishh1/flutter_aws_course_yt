import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutteraws/amplifyconfiguration.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Amplify',
        home: Homepage());
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Amplify amplify = Amplify();
  bool isConfigured = false;

  @override
  void initState() {
    super.initState();
    if (!isConfigured) config();
  }

  void config() async {
    amplify.configure(amplifyconfig);
    setState(() {
      isConfigured = true;
      print('Configuration is $isConfigured');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appbar:AppBar(),
      body:Container()
    )
  }
}
