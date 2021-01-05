import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'IntroScreen.dart';
import '../theme.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }

}

class _SignUp extends State<SignUp>{
  final key = GlobalKey<FormState>();
  TextEditingController vaccine = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController verification = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Text("SIGNUP",style:  GoogleFonts.aBeeZee(fontSize: 50,fontWeight: FontWeight.w900,color: blue),),
            SizedBox(
              height: 30,
            ),
            Form(
              key: key,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                    child: TextFormField(
                      style: subheading,
                      controller: name,
                      validator: MinLengthValidator(1,errorText: "Name cannot be empty"),
                      decoration: InputDecoration(
                        labelText: 'Company Name',
                        labelStyle: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey,width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.grey,width: 2),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
                    child: TextFormField(
                      style: subheading,
                      controller: location,
                      validator: RequiredValidator(errorText: "Location is a required field"),
                      decoration: InputDecoration(
                        labelText: 'Location',
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
                    child: TextFormField(
                      style: subheading,
                      controller: verification,
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
                    child: TextFormField(
                      style: subheading,
                      controller: contact,
                      validator: MinLengthValidator(10,errorText: "Please input correct mobile number"),
                      decoration: InputDecoration(
                        labelText: 'Contact Info',
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
                    child: TextFormField(
                      style: subheading,
                      controller: vaccine,
                      validator: RequiredValidator(errorText: "Vaccine Name is a required field"),
                      decoration: InputDecoration(
                        labelText: 'Vaccine Name',
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
                if(key.currentState.validate()) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IntroScreen()));
                }
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("SIGNUP",style: heading1),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text("Existing User? Log In Here!",style: subheading),
              ),
              onTap: () async {
                Navigator.pop(context);
              },
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

}