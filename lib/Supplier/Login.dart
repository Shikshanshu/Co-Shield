import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'IntroScreen.dart';
import '../theme.dart';
import 'SignUp.dart';
//In the prototype we are keeping the login function open incase the organization is unable to set up truffle other functionality can be tested
class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Login();
  }

}

class _Login extends State<Login>{
  final key = GlobalKey<FormState>();
  TextEditingController government = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text("LOGIN",style:  GoogleFonts.aBeeZee(fontSize: 50,fontWeight: FontWeight.w900,color: blue),),
              SizedBox(
                height: 30,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>IntroScreen()));
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
              )
            ],
        ),
      ),
    );
  }

}