import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'IntroScreen.dart';
import '../theme.dart';
import 'SignUp.dart';
class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }

}
bool loading = false;
class _Login extends State<Login>{
  final key = GlobalKey<FormState>();
  TextEditingController government = new TextEditingController();
  Future<void> getSupplier() async {
    http.Response response = await http.post("http://127.0.0.1:8545/getdistributor",body: {
      "id": government.text,
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
      print(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("supplier", government.text);
      prefs.setBool("guest", false);
      setState(() {
        loading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }
  @override
  void initState() {
    loading =false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading)?Center(
        child: CircularProgressIndicator(),
      ):Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.width/1.25,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "Assets/login.png"
                  ),
                  fit: BoxFit.fill,
                )
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width/1.25,
                  child: Center(
                    child: Text("LOGIN",style: GoogleFonts.aBeeZee(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
                Form(
                  key: key,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
                        child: TextFormField(
                          style: subheading,
                          controller: government,
                          validator: RequiredValidator(errorText: "Please input correct verification id"),
                          decoration: InputDecoration(
                            labelText: 'Verification Id',
                            hintText: "Please provide government authorized id",
                            hintStyle: GoogleFonts.aBeeZee(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.grey),
                            labelStyle: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.grey,width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.grey,width: 2.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.red,width: 2),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.red,width: 2),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                  color: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onPressed: () async {
                    if(key.currentState.validate())
                    {
                      setState(() {
                        loading = true;
                      });
                      getSupplier();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("LOGIN",style: heading1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("New User? Sign Up Here!",style: subheading),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Continue as guest?",style: subheading),
                  ),
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('guest', true);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroScreen()));
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}