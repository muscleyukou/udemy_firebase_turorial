import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


class PhoneSignInScreen extends StatefulWidget {
  @override
  _PhoneSignInScreenState createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Sign In'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
         InternationalPhoneNumberInput(
           onInputChanged: (phoneNumberTXT){
             print(phoneNumberTXT);
           },
         ),
            ],
          ),
        ),
      ),
    );
  }
}
