import 'dart:convert';

import 'package:blockchain/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class VaccineInfo extends StatefulWidget{
  Barcode barcode;
  VaccineInfo(this.barcode);
  @override
  State<StatefulWidget> createState() {
    return _VaccineInfo(barcode);
  }

}
bool loading = true;
class _VaccineInfo extends State<VaccineInfo>{
  Barcode barcode;
  String temp;
  String location,time;
  String distributor;
  _VaccineInfo(this.barcode);
  Future<void> setDatafromBackend() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool("guest"))
      {
        temp = "-70";
        location = "New Delhi, Delhi";
        time = "18 minutes";
        distributor = "Sun Pharmaceuticals";
      }
    else
      {
        http.Response response = await http.post("http://127.0.0.1:8545/getvaccine",body: {
          "id": barcode.code
        });
        var json = jsonDecode(response.body);
        if(json['success']=="0")
        {
          setState(() {
            loading = false;
          });
          Fluttertoast.showToast(msg: "Cannot find vaccine with given Id");
          Navigator.pop(context);
        }
        temp = json['temp'];
        location = "New Delhi, Delhi";
        time = "18 minutes";
        distributor = json['distributorName'];
      }

    setState(() {
      loading = false;
    });
  }
  @override
  void initState() {
    loading = true;
    setDatafromBackend();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(87, 114, 195,1),
      body: (loading)?Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Center(
              child: Text("Vaccine Id: "+barcode.code,style: subheading1,),
            ),
            Container(
              height: MediaQuery.of(context).size.width-100,
              width: MediaQuery.of(context).size.width-100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("Assets/vaccineInfobg.png"),
                )
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Icon(Icons.thermostat_rounded,color: Colors.white,size: 60,),
                  SizedBox(width: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width-130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Text("Temperature Control",style: subheading1,),
                         RichText(
                           textAlign: TextAlign.center,
                           text: TextSpan(
                             style: normal1,
                             children: [
                               TextSpan(
                                 text: "A sensor attached to each vehicle shows this vaccine was maintained at ",
                               ),
                               TextSpan(
                                 text: temp,
                                 style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                               ),
                               TextSpan(
                                 text: " Temperature"
                               )
                             ]
                           ),
                         )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Icon(Icons.location_on_rounded,color: Colors.white,size: 60,),
                  SizedBox(width: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width-130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Location and Route",style: subheading1,),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: normal1,
                              children: [
                                TextSpan(
                                  text: "Monitoring real time traffic details with accurate route optimization your vaccine originated from ",
                                ),
                                TextSpan(
                                    text: location,
                                    style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                                ),
                                TextSpan(
                                    text: " and was delivered to you in "
                                ),
                                TextSpan(
                                    text: time,
                                    style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                                ),
                              ]
                          ),
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Icon(Icons.location_city_rounded,color: Colors.white,size: 60,),
                  SizedBox(width: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width-130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("ORGANIZATION",style: subheading1,),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: normal1,
                              children: [
                                TextSpan(
                                  text: "This vaccine has been delivered to you by ",
                                ),
                                TextSpan(
                                    text: distributor,
                                    style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                                ),
                              ]
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}