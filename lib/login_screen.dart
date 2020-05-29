import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasks/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasks/screen/email_path_signup.dart';
import 'package:tasks/screen/sign_in_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.only(bottom: 80),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Color(0xFF000C58D),
                    blurRadius: 30,
                    offset: Offset(10, 10),
                    spreadRadius: 0)
              ]),
              child: Image(
                image: AssetImage('asset/logo_round.png'),
                width: 200,
                height: 200,
              ),
            ),
            Container(
              child: Text(
                'Log In',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              margin: EdgeInsets.only(top: 20),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(top: 40.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Write Email Here'),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Write Email Here'),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
              ),
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    primaryColor,
                    secondaryColor,
                  ], end: Alignment.topLeft, begin: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Center(
                    child: Text(
                      'LogIn with Email',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              onTap: () {
                _signIn();
              },
            ),
            FlatButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailPathSignUp()));
            }, child: Text('Signup Using Email')),
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Wrap(
                children: <Widget>[
                  FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      FontAwesomeIcons.google,
                      color: Colors.redAccent,
                    ),
                    label: Text('Sign in Using Gmail '),
                  ),
                  FlatButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>PhoneSignInScreen()));},
                    icon: Icon(
                      Icons.phone,
                      color: Colors.blue,
                    ),
                    label: Text('Sign in Using Phone'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      _auth.signInWithEmailAndPassword(
          email: email,
          password: password).then((user) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text('Done'),
                content: Text('Sign in Success'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('cancel')),
                ],
              );
            });
      }).catchError((e){
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                title: Text('Errorr'),
                content: Text(e.toString()),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('cancel')),
                  FlatButton(
                      onPressed: () {
                        _emailController.text = '';
                        _passwordController.text = '';
                        Navigator.of(ctx).pop();
                      },
                      child: Text('ok'))
                ],
              );
            });
      });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Text('Errorr'),
              content: Text('Please Provide Email and Password...'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('cancel')),
                FlatButton(
                    onPressed: () {
                      _emailController.text = '';
                      _passwordController.text = '';
                      Navigator.of(ctx).pop();
                    },
                    child: Text('ok'))
              ],
            );
          });
    }
  }
}
