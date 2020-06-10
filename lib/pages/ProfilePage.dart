import 'package:qrcode_app/models/User.dart';
import 'package:qrcode_app/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_app/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).user;

    return Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff8589f0),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60))),
                    )),
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        Text(
                          user.username,
                          style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.04,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Card(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Center(
                              child: ListTile(
                                leading: Icon(
                                  Icons.call,
                                  color: Color(0xFF8480f0),
                                ),
                                title: Text(user.contact,
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Card(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Center(
                              child: ListTile(
                                leading: Icon(
                                  Icons.mail,
                                  color: Color(0xFF8480f0),
                                ),
                                title: Text(user.email,
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ),
                          ),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .02,
                        ),
                        Card(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Center(
                              child: ListTile(
                                leading: Icon(
                                  Icons.group,
                                  color: Color(0xFF8480f0),
                                ),
                                title: Text(
                                  user.specialite,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Spacer(),
                        (user.userIsSuperuser == true ) ?
                        GestureDetector(
                          onTap: () {
                            Provider.of<UserProvider>(context, listen: false)
                                .logout();
                            Navigator.pushNamedAndRemoveUntil(
                                context, LoginPage.routeName, (route) => false);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xff8589f0),
                                borderRadius: BorderRadius.circular(20)),
                            height: MediaQuery.of(context).size.height * .08,
                            margin: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height * .04,
                                right: 30,
                                left: 30),
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(
                                    Icons.subdirectory_arrow_left,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Text(
                                    "Logout",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                  ),
                                  Container()
                                ],
                              ),
                            ),
                          ),
                        )
                            :
                            Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .05,
              right: 20,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /*CircleAvatar(
                    backgroundColor: Color(0xff8489f0),
                    radius: MediaQuery.of(context).size.height / 13,
                    backgroundImage: NetworkImage(user.image),
                  )

                   */
                ],
              ),
            )
          ],
        ));
  }
}
