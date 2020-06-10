import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flare_flutter/flare_actor.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_app/providers/UserProvider.dart';
import 'package:qrcode_app/widgets/anim.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum QrState {SUCCESS, FAILURE, NONE}

class QrCodePage extends StatefulWidget {

  static const routeName = '/qrcode';
  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {


  QrState res = QrState.NONE;
  String message = '';

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          //"#ff6666", "Cancel", true, ScanMode.QR);
      barcodeScanRes = await scanner.scan();

      await Provider.of<UserProvider>(context, listen: false).fetchScan(scan: barcodeScanRes);
      setState(() {
        res = QrState.SUCCESS;
      });

    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      setState(() {
        res = QrState.FAILURE;
      });
    } catch(e) {
      print(e);
      setState(() {
        res = QrState.FAILURE;
      });
    }
  }


Widget scanwidget() {

    return Container(
      color: Color(0xff8589f0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          Expanded(
            flex: 1,
            child: Container(
              child:  Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(padding: EdgeInsets.all(30),
                      child: Icon(Icons.close, size: 35, color: Colors.black,)),
                ),
              ),
            ),
          ),

          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Hero(
                    tag: "#scan",
                    child: Container(
                        height: MediaQuery.of(context).size.height / 2.9,
                        width: MediaQuery.of(context).size.width / 1.5,
                        child: FlareActor("images/barcode_scan.flr", alignment:Alignment.center, fit:BoxFit.cover, animation:"scan")),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    padding: EdgeInsets.only(left: 12),
                    child: Text("message was in flight, we want to discard the reply rather than calling"),
                    width: MediaQuery.of(context).size.width / 1.2,
                  ),



                ],
              )),

          Expanded(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: ()async{
                    scanQR();
                  },
                  child: Container(
                    child: Text(
                      "Scanner".toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff8489f0)),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 4))
                        ]),
                  ),
                ),

              ],
            ),
          )




        ],
      ),
    );
}
  @override
  Widget build(BuildContext context) {

    bool isload =  Provider.of<UserProvider>(context).isloading;
    String response =  Provider.of<UserProvider>(context).message;

    //scanWidget: homepage
    //first true successpage
    //second false error page
    return Scaffold(
      backgroundColor: Color(0xff8489f0),
      body: isload ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitWanderingCubes(
            color: Colors.white,
            size: 80,
          ),
          SizedBox(height: 55,),
          Text("Veuillez patienter ...", style: TextStyle(color: Colors.white, fontSize: 18),)
        ],
      ) : Container(
        child: (res == QrState.NONE) ? scanwidget() : Container(
            child:(res == QrState.SUCCESS) ?  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child:CheckAnimation(),),
                SizedBox(height: 30,),
                Text(response, style: TextStyle( color: Colors.white),),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.all(20),
                    child: Text('Retour',style: TextStyle(color:Color(0xff8489f0),fontSize: 16,fontWeight: FontWeight.bold),),

                  ),
                )
                ,
              ],
            ) :  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(child: Icon(Icons.close, size: 50, color: Colors.red,),),
                SizedBox(height: 20,),
                Text("$response",textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    margin: EdgeInsets.all(20),
                    child: Text('Retour',style: TextStyle(color:Color(0xff8489f0),fontSize: 16,fontWeight: FontWeight.bold),),

                  ),
                )
              ],
            )
        ),
      )
    );
  }

}
