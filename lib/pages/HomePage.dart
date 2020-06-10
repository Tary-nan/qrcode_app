import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'ProfilePage.dart';
import 'QrCodePage.dart';

class HomePage extends StatelessWidget {

  static const routeName="/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f6ff),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Expanded(
            flex: 1,
            child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[

                    Container(
                      height: MediaQuery.of(context).size.height*.07,
                      width: 100,
                      child: Image.asset("images/logo-nan.png"),
                    )

                  ],
                )),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Expanded(
                            flex:3,
                              child: Container(
                                padding: EdgeInsets.only(left: 40),

                            child: Text("présence NaN".toUpperCase(), style: TextStyle(color:Colors.white,fontWeight: FontWeight.w600, fontSize: 16),),)),
                          Expanded(child: Container(
                            child: FlareActor("images/BarcodeScanner.flr", alignment:Alignment.center, fit:BoxFit.cover, animation:"scan"),)),

                        ],
                      ),
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: MediaQuery.of(context).size.height / 3.7,
                      decoration: BoxDecoration(
                        color: Color(0xff2ea2a2),
                        // color: Color(0xff2e2a2a),
                        // color: Color(0xff8489F0),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 7,
                      height: MediaQuery.of(context).size.height / 4.1,
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,

                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Nos Services".toUpperCase(),
                        style: TextStyle(color: Color(0xff8489f0),
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          print('Scann');
                          Navigator.pushNamed(context, QrCodePage.routeName);
                         
                        },
                        child: Hero(
                          tag: "#scan",
                          child: Container(

                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 9,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Image.asset(
                                      'images/scanqr.png',
                                      fit: BoxFit.contain,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("#Scanner", style: TextStyle(color: Colors.white,fontSize: 16),),
                                          Icon(Icons.phone_iphone,color: Colors.white,)
                                        ],
                                      )
                                  ),
                                )
                              ],
                            ),

                            height: MediaQuery.of(context).size.height /3,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                              color: Color(0xff2ea2a2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, ProfilePage.routeName);
                        },
                        child: Hero(
                          tag: "#profile",
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 9,
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: SvgPicture.asset(
                                      'images/undraw_swipe_profiles1_i6mr.svg',
                                      fit: BoxFit.contain,
                                      height: 100,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text("#Profile", style: TextStyle(color: Colors.white,fontSize: 16)),
                                          Icon(Icons.person,color: Colors.white,)
                                        ],
                                      )
                                  ),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(right: 10),
                            height: MediaQuery.of(context).size.height /3,
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                              color: Color(0xff2ea2a2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
