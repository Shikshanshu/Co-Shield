import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class AddVaccine extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddVaccine();
  }

}

class _AddVaccine extends State<AddVaccine>{
  final key = GlobalKey<FormState>();
  TextEditingController vaccineId = new TextEditingController();
  TextEditingController aadhaarId = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(87, 114, 195,1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
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
                      style: subheading1,
                      controller: vaccineId,
                      validator: RequiredValidator(errorText: "Vaccine Id is a required field"),
                      decoration: InputDecoration(
                        labelText: 'Vaccine Id',
                        labelStyle: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white,width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white,width: 2),
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
                      style: subheading1,
                      controller: aadhaarId,
                      validator: RequiredValidator(errorText: "Aadhar Id is required Field"),
                      decoration: InputDecoration(
                        labelText: 'User Aadhaar Id',
                        labelStyle:  GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white,width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(color: Colors.white,width: 2.0),
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
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () async {
                if(key.currentState.validate())
                {
                  Fluttertoast.showToast(msg: "User data has been successfully updated");
                  Navigator.pop(context);
                }
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Register",style: heading1),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

}