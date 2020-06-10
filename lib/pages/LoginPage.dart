import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_app/utils/clipContainer.dart';
import '../providers/UserProvider.dart';

import 'LoaderPage.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool valid = true;

  GlobalKey<FormState> _form = GlobalKey();

  TextEditingController _username = TextEditingController();

  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf5f6ff),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: ClipPath(
                      clipper: ImageClipper(),
                      child: Container(
                        color: Color(0XFF8489f0),
                        width: double.infinity,
                        child: Stack(children: [
                          Positioned(
                              child: SvgPicture.asset(
                            'images/undraw_personalization_triu.svg',
                            fit: BoxFit.cover,
                          )),
                        ]),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Form(
                    key: _form,
                    child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: double.infinity,
                        child: Column(children: <Widget>[
                          (valid) ? Container() : Text('Veuillez remplir les champs',style: TextStyle(color: Colors.red),),
                          SizedBox(
                            height: 10,
                          ),
                          InputLogin(
                              placeholder: "Username",
                              icon: Icons.person,
                              textEditingController: _username,
                              ishide: false),
                          SizedBox(
                            height: 15,
                          ),
                          InputLogin(
                              placeholder: "Password",
                              textEditingController: _password,
                              icon: Icons.vpn_key,
                              ishide: true),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () async {
                              print(_username.text);
                              if(_username.text.isNotEmpty && _password.text.isNotEmpty) {
                                setState(() {
                                  valid = true;
                                });
                                await Provider.of<UserProvider>(context, listen: false).setLogin(username: _username.text, password: _password.text);
                                Navigator.pushNamed(context, LoaderPage.routeName);
                              } else {
                                setState(() {
                                  valid = false;
                                });
                              }
                            },
                            child: Container(
                              child: Text(
                                "Connexion".toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffffffff)),
                              ),
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              width: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                  color: Color(0xff8589f0),
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 4))
                                  ]),
                            ),
                          )

                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () async {
                                  print(_username.text);
                                  if(_username.text.isNotEmpty && _password.text.isNotEmpty) {
                                    setState(() {
                                      valid = true;
                                    });
                                  await Provider.of<UserProvider>(context, listen: false).login();
                                    Navigator.pushNamed(context, LoaderPage.routeName);
                                  } else {
                                    setState(() {
                                      valid = false;
                                    });
                                  }
                                },
                                child: Container(
                                  child: Text(
                                    "Submit".toUpperCase(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffffffff)),
                                  ),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      color: Color(0xff8589f0),
                                      borderRadius: BorderRadius.circular(40),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 4,
                                            offset: Offset(0, 4))
                                      ]),
                                ),
                              )
                            ],
                          ),*/
                        ])),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class InputLogin extends StatelessWidget {
  String placeholder;
  IconData icon;
  bool ishide;
  TextEditingController textEditingController;

  InputLogin({this.placeholder, this.icon, this.ishide, this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 40,
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextFormField(
            obscureText: ishide,
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
              enabledBorder: InputBorder.none,
              suffixIcon: Icon(icon),
              border: InputBorder.none,
            ),
          ),
          decoration: BoxDecoration(
              color: Color(0xffe7e7e7),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, 4))
              ]),
        );
  }
}
