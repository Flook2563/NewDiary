import 'package:dear_diary/utils/input_validator.dart';
import 'package:dear_diary/view_model/base.dart';
import 'package:dear_diary/view_model/user.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class SignUp extends StatefulWidget {
  static const routeName = 'signup';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TapGestureRecognizer _loginTapRecognizer;
  final _signUpFormKey = GlobalKey<FormState>();
  Map<String, String> _formData = {};

  @override
  void initState() {
    super.initState();
    _loginTapRecognizer = TapGestureRecognizer()..onTap = _handleLoginTap;
  }

  _handleLoginTap() {
    Navigator.of(context).pushNamed(Login.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          customBorder: CircleBorder(),
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
//          Icons.keyboard_arrow_left
            color: Color.fromRGBO(90, 97, 117, 1),
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Form(
                key: _signUpFormKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.grey.shade700,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox( width: 8.0, height: 20.0, ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('Name'),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        validator: InputValidator.name,
                        onSaved: (value) => _formData['fullname'] = value,
                        cursorColor: Color(0xFF3C4858),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: 'กรุณากรอกชื่อ?',
                            suffixIcon: Icon(Icons.person_outline)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('Email'),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        validator: InputValidator.email,
                        onSaved: (value) => _formData['email'] = value,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color(0xFF3C4858),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: 'กรุณากรอก Email?',
                            suffixIcon: Icon(Icons.alternate_email)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('Password'),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        validator: InputValidator.password,
                        onSaved: (value) => _formData['password'] = value,
                        obscureText: true,
                        cursorColor: Color(0xFF3C4858),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: 'กรุณากรอก Password',
                            suffixIcon: Icon(Icons.lock_outline)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text('Password'),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: TextFormField(
                        validator: InputValidator.password,
                        onSaved: (value) => _formData['copassword'] = value,
                        obscureText: true,
                        cursorColor: Color(0xFF3C4858),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            hintText: 'กรุณากรอก Co-Password',
                            suffixIcon: Icon(Icons.lock_outline)),
                      ),
                    ),
                    Container(
                      width: 320,
                      height: 60,
                      margin: EdgeInsets.only(top: 40, bottom: 30.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF3C4858).withOpacity(.4),
                              offset: Offset(10.0, 10.0),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: RaisedButton(
                        color: Color(0xFF3C4858),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        onPressed: () {
                          if (Provider.of<UserViewModel>(context).viewStatus ==
                              ViewStatus.Loading) return;
                          final form = _signUpFormKey.currentState;
                          if (form.validate()) {
                            form.save();
                            _handleSignUp();
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 40.0),
                                child: Provider.of<UserViewModel>(context)
                                            .viewStatus ==
                                        ViewStatus.Loading
                                    ? CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      )
                                    : Text(
                                        'Register',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                      ),
                              ),
                            ),
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF3C4858),
                                size: 20.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _handleSignUp() async {
    final response = await Provider.of<UserViewModel>(context, listen: false)
        .create(_formData);
    if (response) {
      Navigator.of(context).popAndPushNamed(Login.routeName);
    }
  }

  @override
  void dispose() {
    _loginTapRecognizer.dispose();
    super.dispose();
  }
}
