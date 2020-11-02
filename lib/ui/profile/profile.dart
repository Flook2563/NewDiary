import 'package:dear_diary/models/user.dart';
import 'package:dear_diary/utils/auth_helper.dart';
import 'package:dear_diary/view_model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../intro/intro.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserViewModel userViewModel;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userViewModel = Provider.of<UserViewModel>(context);
    if (this.userViewModel != userViewModel) {
      this.userViewModel = userViewModel;
      Future.microtask(userViewModel.getUserProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    User userProfile = Provider.of<UserViewModel>(context).userProfile;
    String message = Provider.of<UserViewModel>(context).message;
    return SafeArea(
      child: userProfile != null
          ? SingleChildScrollView(
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: <Widget>[
                  Container(
                      width: 250.0,
                      height: 250.0,
                      child: Image.asset('images/game.png')),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          margin: EdgeInsets.only(bottom: 40.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(13, 51, 32, 0.1),
                                offset: Offset(0.0, 6.0),
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'ชื่ของคุณ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  userProfile.fullName,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  'Email ของคุณ',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 20.0),
                                child: Text(
                                  userProfile.email,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    child: LogoutButton(),
                  ),
                ],
              ),
            ))
          : Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 40.0),
                    child: Text(message ?? ''),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    width: MediaQuery.of(context).size.width * .9,
                    height: 50,
                    child: LogoutButton(),
                  ),
                ],
              ),
            ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Color(0xff0000ff),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        await AuthHelper.removeUserToken();
        Navigator.of(context).pushNamedAndRemoveUntil(
            Intro.routeName, (Route<dynamic> route) => false);
      },
      child: Text(
        'Logout',
        style: TextStyle(
            color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
