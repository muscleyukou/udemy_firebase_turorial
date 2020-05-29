import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasks/config.dart';


class EmailPathSignUp extends StatefulWidget {
  @override
  _EmailPathSignUpState createState() => _EmailPathSignUpState();
}

class _EmailPathSignUpState extends State<EmailPathSignUp> {
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('email signup'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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
                      hintText: 'Sign up Using Email'),
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
                  _signup();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _signup(){
    final String emailTXT=_emailController.text.trim();
    final String passwordTXT=_passwordController.text;
    if(emailTXT.isNotEmpty&&passwordTXT.isNotEmpty){
   _auth.createUserWithEmailAndPassword(email: emailTXT, password: passwordTXT)
       .then((user){showDialog(context: context,
   builder: (context){
     return AlertDialog(
       shape: RoundedRectangleBorder(),
       title: Text('success'),
       content: Text('sign up process done,you can sign up'),
       actions: <Widget>[
         FlatButton(onPressed: (){
           Navigator.of(context).pop(
           );
         }, child: Text('OK')),
       ],
     );
   });

   }).catchError((e){
     showDialog(context: context,
     builder: (ctx){
       return AlertDialog(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
         content: Text('${e.message}'),
         actions: <Widget>[
           FlatButton(onPressed: (){
             Navigator.of(ctx).pop();
           }, child: Text('cancel'))
         ],
       );
     });
   });
    }else{
      showDialog(context: context,
      builder: (ctx){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text('Error'),
          content: Text('please provide email and password'),
          actions: <Widget>[
            FlatButton(onPressed:(){
              Navigator.of(ctx).pop();
            }, child: Text('OK')),
          ],
        );
      });
    }
  }
}
