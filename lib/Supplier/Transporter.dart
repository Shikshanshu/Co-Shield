import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

class Transporter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Transporter();
  }
}
var data = {
  "temp": "-70 °C",
  "vaccines": "5",
  "destination": "India+Gate"
};
class _Transporter extends State<Transporter>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: Icon(Icons.thermostat_rounded,color: Colors.blue,size: 60,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("TEMPERATURE CONTROL",style: subheading1,),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Get the temperature maintained in the refrigerator storing the vaccine to avoid possible cold chain breach",style: normal1,textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(20),
                        backgroundColor: Colors.deepOrangeAccent,
                        content: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: normal1,
                            children: [
                              TextSpan(
                                text: "The data from IoT shows that the vaccines in your refrigerator storage are maintained at a temperature of ",
                              ),
                              TextSpan(
                                text: data['temp'],
                                  style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                              ),
                              TextSpan(
                                text: ". This temperature is ideal as per government guidelines and you don't need to report any damage"
                              )
                            ]
                          ),
                        ),
                      );
                    }
                  );
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
                        child: Icon(Icons.alt_route_rounded,color: Colors.blue,size: 60,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("CONJUNCTION IN ROUTE",style: subheading1,),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Get real time traffic updates in your route with route optimizations for safe vaccine transport",style: normal1,textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  launch("https://www.google.com/maps/dir/?api=1&destination="+data['destination']);
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
                        child: Icon(Icons.inventory,color: Colors.blue,size: 60,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("INVENTORY MANAGEMENT",style: subheading1,),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Get to know how many vaccines are left in your inventory to avoid possible vaccine shortages",style: normal1,textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(20),
                          backgroundColor: Colors.deepOrangeAccent,
                          content: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: normal1,
                                children: [
                                  TextSpan(
                                    text: "The data from IoT shows that there are still ",
                                  ),
                                  TextSpan(
                                      text: data['vaccines'],
                                      style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                                  ),
                                  TextSpan(
                                      text: " vaccines left in your refrigerator storage. It is suggested based on future route congestion that you first pick up more vaccines from nearest storage service."
                                  )
                                ]
                            ),
                          ),
                        );
                      }
                  );
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
                        child: Icon(Icons.warning_rounded,color: Colors.blue,size: 60,),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("VEHICLE FAILURE",style: subheading1,),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("Report of any possible vehicle failure so that we can redirect nearest transporter to you to avoid any damage to the vaccine",style: normal1,textAlign: TextAlign.center,),
                      ),
                    ],
                  ),
                ),
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          contentPadding: EdgeInsets.all(20),
                          actions: [
                            Padding(padding: EdgeInsets.all(10),
                            child: GestureDetector(
                              child: Text("REPORT",style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber),),
                              onTap: (){
                                Fluttertoast.showToast(msg: "Vehicle Failure reported successfully");
                                Navigator.pop(context);
                              },
                            ),)
                          ],
                          backgroundColor: Colors.deepOrangeAccent,
                          content: Text("Your present location will be shared to our servers and the nearest transporter will reach out to you as soon as possible. Do you confirm reporting vehicle failure?",style: normal1,)
                        );
                      }
                  );
                },
              ),
            ],
          ),
        )
    );
  }

}