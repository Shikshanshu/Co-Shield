import 'package:blockchain/QRCodeScanner.dart';
import 'package:blockchain/SupplierList.dart';
import 'package:blockchain/VaccineVerifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'MyDrawer.dart';

class MainPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}
class _MainPage extends State<MainPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Co-Shield",style: heading1,),
        backgroundColor: orange,
        elevation: 0,
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade200
                ),
                child: Column(
                  children: [
                    Center(
                      child: Icon(Icons.qr_code_scanner,color: Colors.blue,size: 60,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("QR CODE SCANNER",style: subheading1,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Get to know whether the vaccine was delivered to you at the right temperature with our special block chain data integrated with IOT",style: normal1,textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCodeScanner()));
              },
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade200
                ),
                child: Column(
                  children: [
                    Center(
                      child: Icon(Icons.verified,color: Colors.blue,size: 60,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("VACCINATED?",style: subheading1,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Got yourself vaccinated from the right authority? Check whether your vaccine data has been updated with the government officials.",style: normal1,textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VaccineVerifier()));
              },
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade200
                ),
                child: Column(
                  children: [
                    Center(
                      child: Icon(Icons.agriculture_rounded,color: Colors.blue,size: 60,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("SUPPLIERS",style: subheading1,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Concerned whether the vaccine provider is fake or not. Get to know all government certified supplier close to your location.",style: normal1,textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierList()));
              },
            ),
          ],
        ),
      )
    );
  }

}