import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'MainPage.dart';
import 'Supplier/MainPage.dart' as sup;
import 'theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login.dart';
import './Supplier/Login.dart' as supplier;

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}
class _SplashScreen extends State<SplashScreen>{
  double visibility1 = 0;
  double visibility2 = 0;
  bool selected = true;
  bool selected2 = true;
  bool position1 = false;
  bool position2 = false;
  double visible = 0;
  String type;
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500),(){
      setState(() {
        selected = false;
      });
    });
    Future.delayed(Duration(milliseconds: 750),(){
      setState(() {
        selected = true;
        position1 = true;
        selected2 = false;
      });
    });
    Future.delayed(Duration(milliseconds: 1000),(){
      setState(() {
        selected2 = true;
        position2 = true;
        visibility1 = 1;
      });
    });
    Future.delayed(Duration(seconds: 1,milliseconds: 250),(){
      setState(() {
        visibility2 = 1;
      });
    });
    Future.delayed(Duration(seconds: 1,milliseconds: 500),(){
      setState(() {
        visible = 1;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Center(
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Assets/initial.png")
                          )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: AnimatedOpacity(
                      child: Text("Co-Shield",style: GoogleFonts.aBeeZee(fontSize: 50,fontWeight: FontWeight.w900,color: primaryBlue),),
                      opacity: visibility1,
                      duration: Duration(milliseconds: 250),
                    )
                  ),
                  AnimatedOpacity(
                    opacity: visibility2,
                    duration: Duration(milliseconds: 250),
                    child: Text("WE CARE FOR YOU",style: GoogleFonts.aBeeZee(fontStyle: FontStyle.italic,fontSize: 20,fontWeight: FontWeight.w500,color: secondaryGreen),),
                  ),

                ],
              ),

            ),
            Positioned(
              top: 300,
              left: (position1)?null:40,
              right: (position1)?40:null,
              child: AnimatedContainer(
                height: 50,
                width: (selected)?0:MediaQuery.of(context).size.width-80,
                color: primaryBlue,
                duration: Duration(milliseconds: 250),
              ),
            ),
            Positioned(
              top: 360,
              left: (position2)?null:40,
              right: (position2)?40:null,
              child: AnimatedContainer(
                height: 50,
                width: (selected2)?0:MediaQuery.of(context).size.width-80,
                color: secondaryGreen,
                duration: Duration(milliseconds: 250),
              ),
            ),
            Positioned(
              top: 400,
              child: ClipPath(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-400,
                  decoration: BoxDecoration(
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
                        height: 200,
                      ),
                      AnimatedOpacity(opacity: visible, duration: Duration(milliseconds: 1000),child: Text("Get started as a :",style: heading1,),),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: AnimatedOpacity(
                          opacity: visible,
                          duration: Duration(milliseconds: 1000),
                          child: RaisedButton(
                            onPressed: () async {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              (prefs.getString("supplier")!=null)?Navigator.push(context,MaterialPageRoute(builder: (context)=>sup.MainPage())):
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>supplier.Login()));
                            },
                            color: Colors.deepPurpleAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("SUPPLIER",style: subheading1),
                            ),
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: visible,
                        duration: Duration(milliseconds: 1000),
                        child: RaisedButton(
                          onPressed: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            (prefs.getString("customer")!=null)?Navigator.push(context,MaterialPageRoute(builder: (context)=>MainPage())):
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>Login()));
                          },
                          color: Colors.deepPurpleAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("CONSUMER",style: subheading1),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                clipper: BottomArc(),
              )
            )
          ],
        )
    );
  }

}
class BottomArc extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        size.width*3 /4, 0, size.width/2, 100);
    path.quadraticBezierTo(size.width/4,200,0,100);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}