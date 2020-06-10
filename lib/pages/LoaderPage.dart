import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_app/models/User.dart';
import 'package:qrcode_app/providers/UserProvider.dart';
import 'package:qrcode_app/widgets/liquid_loader.dart';

import 'HomePage.dart';


class LoaderPage extends StatelessWidget {

  static const routeName = '/loader';


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xFF8480f0),
        body: Center(
          child: FutureBuilder<int>(
            future: Provider.of<UserProvider>(context).login(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                User user = Provider.of<UserProvider>(context).user;
                return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 130,
                          ),
                        SizedBox(height: 20,),
                        Text("Bienvenue ${user.username}".toUpperCase(), style: TextStyle(color:Colors.white,fontSize: 23),),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (route) => false);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top: 15,bottom: 15,right: 25,left: 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.all(20),
                            child: Text('Accueil',style: TextStyle(color:Colors.indigoAccent,fontSize: 16,fontWeight: FontWeight.bold),),

                          ),
                        )
                      ],
                    );
      
          
               } else if (snapshot.hasError) {
                 return Container(
                   margin: EdgeInsets.only(left: 20,right: 20),
                   child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                              Icons.close,
                              color: Colors.redAccent,
                              size: 130,
                            ),
                          SizedBox(height: 20,),

                          Text(snapshot.error.toString().toUpperCase(), style: TextStyle(color:Colors.white,fontSize: 20),),
                          SizedBox(height: 20,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              margin: EdgeInsets.all(20),
                              child: Text('Login',style: TextStyle(color:Colors.indigoAccent,fontSize: 16,fontWeight: FontWeight.bold),),

                            ),
                          )
                        ],
                      ),
                 );

              }
              // By default, show a loading 
              return LoadLiquid();
            },
          ),
        ),
    );
  }
}