import 'dart:convert';

import 'package:blockchain/SupplierFeedback.dart';
import 'package:blockchain/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class VaccineVerifier extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _VaccineVerifier();
  }
}
bool loading;
bool verified;
bool display;
var data;
class _VaccineVerifier extends State<VaccineVerifier>{
  Future<void> getDatafromBackend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('guest')==true)
      {
        setState(() {
          verified = true;
        });
        data = {
          'date': '26 January 2021',
          'at': 'New Delhi',
          'company': "Sun Pharmaceuticals",
          'vaccine': "Phyzer",
          'transporter': "LnT"
        };
        setState(() {
          loading = false;
        });
        Future.delayed(Duration(milliseconds: 100),(){
          setState(() {
            display = true;
          });
        });
      }
    else
      {
        print(prefs.getString('customer'));
        http.Response response = await http.post("http://127.0.0.1:8545/getconsumer",body: {
          "aId": prefs.getString('customer'),
          "password": prefs.getString('password')
        });
        var json = jsonDecode(response.body);
        if(json['success']=="0")
        {
          setState(() {
            loading = false;
          });
          Fluttertoast.showToast(msg: "Sorry! Data could not be found.");
          Navigator.pop(context);
        }
        else
        {
          print(response.body);
          setState(() {
            verified = json['vaccinated'];
          });
          if(verified==true)
            {
              response = await http.post("http://127.0.0.1:8545/getvaccine",body: {
                "id": json["vacId"]
              });
              json = jsonDecode(response.body);
              data = {
                'date': '26 January 2021',
                'at': 'New Delhi',
                'company': json['distributorName'],
                'vaccine': json['vaccineName'],
                'transporter': json['transporter']
              };
            }
          setState(() {
            loading = false;
          });
          Future.delayed(Duration(milliseconds: 100),(){
            setState(() {
              display = true;
            });
          });
        }
      }

  }
  @override
  void initState() {
    verified = null;
    display = false;
    loading = true;
    getDatafromBackend();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return (loading)?Scaffold(
     body: Center(
       child: CircularProgressIndicator(),
     ),
    ):Scaffold(
      body: (verified)?SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: AnimatedContainer(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (!display)?Colors.amber:Colors.green,
                ),
                duration: Duration(seconds: 5),
                curve: Curves.linear,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: (!display)?0:1,
                    child: Icon(Icons.check,color: Colors.white,size: 100,),
                    duration: Duration(seconds: 5),
                    curve: Curves.linear,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: (!display)?0:1,
              duration: Duration(seconds: 5),
              curve: Curves.linear,
              child: Padding(
                padding: EdgeInsets.all(40),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: GoogleFonts.aBeeZee(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black),
                    children: [
                      TextSpan(
                        text: "It has been verified by government officials that you have been successfully vaccinated against COVID-19 on ",
                      ),
                      TextSpan(
                        text: data["date"],
                          style: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green)
                      ),
                      TextSpan(
                        text: " at ",
                      ),
                      TextSpan(
                        text: data["at"],
                          style: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green)
                      ),
                      TextSpan(
                        text: " by ",
                      ),
                      TextSpan(
                        text: data["company"],
                          style: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green)
                      ),
                      TextSpan(
                        text: ". The vaccine was transported by ",
                      ),
                      TextSpan(
                          text: data["transporter"],
                          style: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green)
                      ),
                      TextSpan(
                        text: " which is a leading transporter of vaccine ",
                      ),
                      TextSpan(
                          text: data["vaccine"],
                          style: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green)
                      ),
                    ]
                  ),
                )
              ),
            ),
            SizedBox(
              height: 100,
            ),
            AnimatedOpacity(opacity: (!display)?0:1,curve: Curves.linear, duration: Duration(seconds: 5),child: FlatButton(
              color: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierFeedback()));
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Provide Feedback",style: heading1),
              ),
            ),),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ):SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            Center(
              child: AnimatedContainer(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (!display)?Colors.amber:Colors.red,
                ),
                duration: Duration(seconds: 5),
                curve: Curves.linear,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: (!display)?0:1,
                    child: Icon(Icons.clear,color: Colors.white,size: 100,),
                    duration: Duration(seconds: 5),
                    curve: Curves.linear,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: (!display)?0:1,
              duration: Duration(seconds: 5),
              curve: Curves.linear,
              child: Padding(
                  padding: EdgeInsets.all(40),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: GoogleFonts.aBeeZee(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.w300,color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Your vaccination data has not been registered with the government. Please get yourself vaccinated or contact your vaccine provider for details.",
                          ),
                        ]
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
  
}