import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'IntroScreen.dart';
import '../theme.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }

}
bool loading = false;
class _SignUp extends State<SignUp>{
  final key = GlobalKey<FormState>();
  TextEditingController vaccine = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController verification = new TextEditingController();
  /*Client httpClient;
  Web3Client ethClient;
  Future<DeployedContract> loadContract() async {
    String abiCode = await rootBundle.loadString("Assets/abi1.json");
    String contractAddress = "0xFF7D83835f630a1D32F5fa1fAE9B7488bEbc85E9";

    final contract = DeployedContract(ContractAbi.fromJson(abiCode, "DistributorData"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "148f42ce24eca534b979181506a9e31bd84a7935f714f736a5f6edb11769733e");

    DeployedContract contract = await loadContract();

    final ethFunction = contract.function(functionName);

    var result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
        maxGas: 1000000,
      ),
    );
    return result;
  }
  Future<String> sendCoind() async {
    var response = await submit("AddDistributor", [BigInt.parse(verification.text),name.text,vaccine.text]);
    return response;
  }*/
  Future<void> addSupplier() async {
    http.Response response = await http.post("http://127.0.0.1:8545/adddistributor",body: {
      "id": verification.text,
      "name": name.text,
      "vaccineName": vaccine.text
    });
    var json = jsonDecode(response.body);
    if(json['success']=="0")
    {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg: "Account Already Exists. Please Login!");
    }
    else
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("supplier", verification.text);
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
    super.initState();
    loading = false;
    //httpClient = new Client();
    //ethClient = new Web3Client("http://127.0.0.1:7545", httpClient);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading==true)?Center(
        child: CircularProgressIndicator(),
      ):Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("Assets/signup.png",fit: BoxFit.fill,)
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Text("SIGNUP",style:  GoogleFonts.aBeeZee(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.white),),
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
                          style: subheading,
                          controller: location,
                          validator: RequiredValidator(errorText: "Location is a required field"),
                          decoration: InputDecoration(
                            labelText: 'Location',
                            labelStyle: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
                        child: TextFormField(
                          style: subheading,
                          controller: verification,
                          validator: RequiredValidator(errorText: "Please input correct verification id"),
                          decoration: InputDecoration(
                            labelText: 'Verification Id',
                            hintText: "Please provide government authorized id",
                            hintStyle: GoogleFonts.aBeeZee(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.white),
                            labelStyle: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
                        child: TextFormField(
                          style: subheading,
                          controller: contact,
                          validator: MinLengthValidator(10,errorText: "Please input correct mobile number"),
                          decoration: InputDecoration(
                            labelText: 'Contact Info',
                            hintStyle: GoogleFonts.aBeeZee(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.white),
                            labelStyle: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
                        child: TextFormField(
                          style: subheading,
                          controller: vaccine,
                          validator: RequiredValidator(errorText: "Vaccine Name is a required field"),
                          decoration: InputDecoration(
                            labelText: 'Vaccine Name',
                            hintStyle: GoogleFonts.aBeeZee(fontSize: 12,fontWeight: FontWeight.w300,color: Colors.white),
                            labelStyle: GoogleFonts.aBeeZee(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.white),
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
                  color: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onPressed: () async {
                    if(key.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      addSupplier();
                      //String response = await sendCoind();
                      /*if(response!="error")
                  {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("supplier", verification.text);
                    setState(() {
                      loading = false;
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => IntroScreen()));
                  }
                  else
                  {
                    setState(() {
                      loading = false;
                    });
                    Fluttertoast.showToast(msg: "Error connecting to backend");
                  }*/
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
                    child: Text("Existing User? Log In Here!",style: subheading1),
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
        ],
      )
    );
  }

}