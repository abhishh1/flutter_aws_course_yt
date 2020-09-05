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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isSignIn = false;
  String email;

  @override
  void initState() {
    super.initState();
    if (!isConfigured) config();
  }

  void config() async {
    AmplifyAuthCognito amplifyAuthCognito = AmplifyAuthCognito();
    amplify.addPlugin(authPlugins: [amplifyAuthCognito]);
    amplify.configure(amplifyconfig);
    setState(() {
      isConfigured = true;
      print('Configuration is $isConfigured');
    });
  }
  
Future<String> signUp(LoginData data) async {
    Map<String, dynamic> userAttributes = {'email': emailController.text};

    SignUpResult result = await Amplify.Auth.signUp(
        username: data.name,
        password: data.password,
        options: CognitoSignUpOptions(userAttributes: userAttributes));
    if (result.isSignUpComplete) {
      print('Sign up complete');
    }
    return 'Sign up error';
  }

  Future<String> logIn(LoginData data) async {
    SignInResult result =
        await Amplify.Auth.signIn(username: data.name, password: data.password);
    try {
      if (result.isSignedIn) {
        setState(() {
          isSignIn = true;
          email = data.name;
        });
      }
    } catch (e) {
      print(e);
    }
    return 'Log in error';
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: logIn,
      onSignup: signUp,
      onRecoverPassword: (_) => null,
      title:'Flutter Amplify Auth'
    );
  }
}
