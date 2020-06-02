import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tasks/config.dart';

class PhoneSignInScreen extends StatefulWidget {
  @override
  _PhoneSignInScreenState createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';
  String _message = '';
  String _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _smsController = TextEditingController();

  void onPhoneNumberChange(String number, String internationalizedPhoneNumber,
      String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }
  bool _isSMSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Sign In'),
      ),
      body: SingleChildScrollView(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),

              ),
              _isSMSent ? Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'OTP here',
                    labelText: 'OTP',
                  ),
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                ),
              )
                  : Container(),

              !_isSMSent
                  ? InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          secondaryColor,
                        ],
                        end: Alignment.topLeft,
                        begin: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Center(
                      child: Text(
                        'SENT OTP',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                onTap: () {
                  _verifyPhoneNumber();
                  setState(() {
                    _isSMSent = true;
                  });
                },
              )
                  : InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          secondaryColor,
                        ],
                        end: Alignment.topLeft,
                        begin: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Center(
                      child: Text(
                        'SENT OTP',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                onTap: () {
                  _signInWithPhoneNumber();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });

    final PhoneVerificationCompleted verificationCompleted = (
        AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message = 'Phone number auth credential;$phoneAuthCredential';
      });
      print(_message);
    };
    final PhoneVerificationFailed verificationFailed = (
        AuthException authException) {
      setState(() {
        _message =
        'Phone number verification isn`t failed ${authException.code}'
            'Message:${authException.message}';
        print(_message);
      });
    };
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _signInWithPhoneNumber() async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId,
        smsCode: _smsController.text);
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      if (user != null) {
        _message = 'Success signd in uid' + user.uid;
        print(_message);
      } else {
        _message = 'Sign in failed';
      }
    });
  }
}
