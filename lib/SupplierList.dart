import 'dart:convert';

import 'package:blockchain/SupplierInfo.dart';
import 'package:blockchain/theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class SupplierList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SupplierList();
  }
}
List<dynamic> suppliers = new List();//["Sun Pharmaceuticals","Global Medicos","98.6 Medications","City Hospital Pharmacy","Jubilant Life Sciences","Mankind Pharmaceuticals"];
bool loading =true;
class _SupplierList extends State<SupplierList>{
  void getData() async{
    suppliers = new List();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('guest'))
      {
        suppliers = [
          {
            "id": "1",
            "name": "Sun Pharmaceuticals",
            "vaccine": "Phyzer"
          },
          {
            "id": "2",
            "name": "Bharat BioTech",
            "vaccine": "No Virus"
          },
          {
            "id": "3",
            "name": "Serum Institute",
            "vaccine": "CoviShield"
          },
          {
            "id": "4",
            "name": "Zydus Cadila",
            "vaccine": "GoCorona"
          },
          {
            "id": "5",
            "name": "Panacea Biotec",
            "vaccine": "CoronaGo"
          },
          {
            "id": "6",
            "name": "Indian Immunologicals",
            "vaccine": "Covaxin"
          }
        ] ;
      }
    else
      {
        for(int i=1;;i++)
        {
          http.Response response = await http.post("http://127.0.0.1:8545/getdistributorbyindex",body: {
            "index": i.toString()
          });

          var json = jsonDecode(response.body);
          print(json['success']);
          if(json['success']=="0")
            break;
          else
          {
            suppliers.add({
              'id': json['id'],
              'name': json['name'],
              'vaccine': json['vaccineName']
            });
          }
        }
      }
        setState(() {
          loading = false;
        });
  }
  @override
  void initState() {
    loading =true;
    suppliers = new List();
    getData();
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
              height: MediaQuery.of(context).size.height/6,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: suppliers.map((e){
                    return MyTile(e,context);
                  }).toList()
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget MyTile(dynamic text,BuildContext context)
  {
    return GestureDetector(
      child: Column(
        children: [
          ListTile(
            title: Text(text['name'],style: normal,),
            trailing: Icon(Icons.arrow_forward),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          )
        ],
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierInfo(text)));
      },
    );
  }
}
