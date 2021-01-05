import 'package:blockchain/Supplier/AddVaccine.dart';
import 'package:blockchain/Supplier/SupplierInfo.dart';
import 'package:blockchain/Supplier/Transporter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MyDrawer.dart';
import '../theme.dart';

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
        title: Text("HEALTH BUDDY",style: heading1,),
        backgroundColor: orange,
        elevation: 0,
      ),
      drawer: buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
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
                      child: Icon(Icons.account_circle_rounded,color: Colors.blue,size: 60,),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("YOUR PROFILE",style: subheading1,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Get to know how our consumers see your profile with real updates based on customer reviews.",style: normal1,textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SupplierInfo()));
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
                      child: Text("VACCINES DELIVERED",style: subheading1,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Delivered vaccine to any of our consumer? Help us maintain the account by verifying the consumer's aadhaar id.",style: normal1,textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddVaccine()));
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
                      child: Text("TRANSPORTER",style: subheading1,),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Special features for transporters to help them with route optimizations, report vehicle breakdown to help safe vaccine delivery to consumer.",style: normal1,textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Transporter()));
              },
            ),
          ],
        ),
      )
    );
  }

}