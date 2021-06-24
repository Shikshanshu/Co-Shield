import 'dart:convert';

import 'package:blockchain/theme.dart';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class SupplierInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SupplierInfo();
  }
}
String company = "Sun Pharmaceuticals";
var companyData;
var customerData = {
  "delivery": 7,
  "customer support": 8,
  "service": 6,
  "vaccine security": 10,
  "record update": 5
};
bool loading =true;
class _SupplierInfo extends State<SupplierInfo>{
  List<BarChartModel> data = new List();
  List<Series<BarChartModel, String>> series = new List();
  Future<void> getSupplier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('guest')==true)
      {
        companyData = {
          "location": "New Delhi, Delhi",
          "government id": "123456789",
          "contact": "9876543210",
          "vaccine": "Phyzer",
        };
        company = "Sun Pharmaceuticals";
        setState(() {
          loading = false;
        });
      }
    else
      {
        http.Response response = await http.post("http://127.0.0.1:8545/getdistributor",body: {
          "id": prefs.getString("supplier"),
        });
        var json = jsonDecode(response.body);
        if(json['success']=="0")
        {
          setState(() {
            loading = false;
          });
          Fluttertoast.showToast(msg: "Account Does not Exist. Please SignUp!");
        }
        else
        {
          companyData = {
            "location": "New Delhi, Delhi",
            "government id": json['id'],
            "contact": "9876543210",
            "vaccine": json['vaccineName'],
          };
          company = json['name'];
          setState(() {
            loading = false;
          });
        }
      }
  }
  @override
  void initState() {
    loading = true;
    data.add(BarChartModel("delivery",customerData["delivery"],Colors.red));
    data.add(BarChartModel("customer support",customerData["customer support"],Colors.orange));
    data.add(BarChartModel("service",customerData["service"],Colors.amber));
    data.add(BarChartModel("vaccine security",customerData["vaccine security"],Colors.green));
    data.add(BarChartModel("record update",customerData["record update"],Colors.purple));
    for(int i=0;i<data.length;i++)
      {
        series.add(
          Series(
              id: "CUSTOMER REVIEW",
              data: data,
              domainFn: (BarChartModel series, _) => "  ",
              measureFn: (BarChartModel series, _) => data[i].value,
              colorFn: (BarChartModel series, _) => ColorUtil.fromDartColor(data[i].color),
          )
        );
      }
    getSupplier();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading)?Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(company,style: heading,),
            Padding(
              padding: EdgeInsets.all(40),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.w300,color: Colors.black),
                  children: [
                    TextSpan(
                      text: "The company is registered to provide vaccine against COVID-19 as per government certification id ",
                    ),
                    TextSpan(
                      text: companyData['government id'],
                        style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                    ),
                    TextSpan(
                      text: " in ",
                    ),
                    TextSpan(
                      text: companyData['location'],
                        style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                    ),
                    TextSpan(
                      text: " supplied to them by company ",
                    ),
                    TextSpan(
                        text: companyData['vaccine'],
                        style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                    ),
                    TextSpan(
                      text: ". For further information please contact them at ",
                    ),
                    TextSpan(
                      text: companyData['contact'],
                        style: GoogleFonts.aBeeZee(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.amber)
                    ),
                  ]
                ),
              ),
            ),
            Text("Customer Review",style: subheading),
            Container(
              height: 400,
              padding: EdgeInsets.all(10),
              child: BarChart(series,
                animate: true,
                animationDuration: Duration(seconds: 2),
              ),
            ),
            Column(
              children: data.map((e){
                return Row(
                  children: [
                    SizedBox(width: MediaQuery.of(context).size.width/2-70),
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: e.color,
                        shape: BoxShape.circle
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(e.data,style: normal,),
                  ],
                );
              }).toList(),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
class BarChartModel {
  String data;
  int value;
  MaterialColor color;

  BarChartModel(this.data, this.value, this.color);
}
