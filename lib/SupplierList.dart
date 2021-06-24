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
            "name": "Sun\nPharmaceuticals",
            "vaccine": "Phyzer",
            "logo": "vaccine"
          },
          {
            "id": "2",
            "name": "Bharat\nBioTech",
            "vaccine": "No Virus",
            "logo": "vaccine1"
          },
          {
            "id": "3",
            "name": "Serum\nInstitute",
            "vaccine": "CoviShield",
            "logo": "vaccine2"
          },
          {
            "id": "4",
            "name": "Zydus\nCadila",
            "vaccine": "GoCorona",
            "logo": "vaccine3"
          },
          {
            "id": "5",
            "name": "Panacea\nBiotec",
            "vaccine": "CoronaGo",
            "logo": "vaccine4"
          },
          {
            "id": "6",
            "name": "Indian\nImmunologicals",
            "vaccine": "Covaxin",
            "logo": "vaccine5"
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
              'vaccine': json['vaccineName'],
              'logo': "vaccine"+(suppliers.length%6).toString(),
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
              height: 30,
            ),
            SingleChildScrollView(
              child: Wrap(
                  children: suppliers.map((e){
                    return newTile(e,context);
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
  Widget newTile(dynamic text,BuildContext context)
  {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierInfo(text)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width/2-30,
        height: 180,
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(33,147,176,1),
              Color.fromRGBO(109,213,237,1),
            ]
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/"+text["logo"]+".png"),
                    fit: BoxFit.fill,
                  )
                ),
              )
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(text['name'],textAlign: TextAlign.center,style: normal1,),
            )
          ],
        ),
      ),
    );
  }
}
