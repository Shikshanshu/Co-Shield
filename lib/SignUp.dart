import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'IntroScreen.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SignUp();
  }

}
bool loading = false;
class _SignUp extends State<SignUp>{
  final key = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController aadhar = new TextEditingController();
  Client httpClient;
  Web3Client ethClient;
  Future<DeployedContract> loadContract() async {
    String abiCode = await rootBundle.loadString("Assets/abi.json");
    String contractAddress = "0xB3EAA93Ac55a0A15f9688209836931C6aD1Ff9eD";

    final contract = DeployedContract(ContractAbi.fromJson(abiCode, "ConsumerData"),
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
    ).catchError((err){
      return "error";
    });
    return result;
  }
  Future<String> sendCoind() async {
    var response = await submit("AddConsumer", [BigInt.parse(aadhar.text),name.text,BigInt.parse(age.text)]).catchError((err){
      return "error";
    });
    return response;
  }
  @override
  void initState() {
    super.initState();
    loading = false;
    httpClient = new Client();
    ethClient = new Web3Client("http://127.0.0.1:7545", httpClient);
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
              height: 70,
            ),
            Text("SIGNUP",style:  GoogleFonts.aBeeZee(fontSize: 50,fontWeight: FontWeight.w900,color: orange ),),
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
                        labelText: 'Username',
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
                      controller: age,
                      validator: RequiredValidator(errorText: "Age is a required field"),
                      decoration: InputDecoration(
                        labelText: 'Age',
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
                      controller: aadhar,
                      keyboardType: TextInputType.number,
                      validator: MinLengthValidator(12,errorText: "Please input correct aadhaar number"),
                      decoration: InputDecoration(
                        labelText: 'Aadhaar Number',
                        hintText: "Please input your 12 digit Aadhaar Number (UID)",
                        hintStyle: subheading,
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
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                    child: TextFormField(
                      style: subheading,
                      controller: email,
                      validator: MultiValidator(
                        [
                          EmailValidator(errorText: "Provide Email in correct format"),
                          RequiredValidator(errorText: "Email is required field")
                        ]
                      ),
                      decoration: InputDecoration(
                        labelText: 'E-Mail',
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
                      controller: password,
                      validator: MinLengthValidator(8,errorText: "Password cannot be less than 8 characters"),
                      decoration: InputDecoration(
                        labelText: 'Password',
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
                  setState(() {
                    loading = true;
                  });
                  String response = await sendCoind();
                  if(response!="error")
                    {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setString("customer", aadhar.text);
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
                    }
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