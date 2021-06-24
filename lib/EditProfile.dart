import 'package:blockchain/ChatMessages.dart';
import 'package:blockchain/CovidChecker.dart';
import 'package:blockchain/UploadDocuments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'Reminders.dart';
import 'theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EditProfile();
  }
}
List<String> tiles = ["Upload Medical Records","Take a Quick Check Up","Join Chat Communities","Set-up Reminders for important tasks"];
List<IconData> icons = [Icons.description,Icons.fact_check,Icons.chat_bubble,Icons.date_range_rounded];
bool loading = true;
class _EditProfile extends State<EditProfile> {
  double value = 0.4;
  void getPrefs() async{
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //value = prefs.getDouble("score")==null?0.4:prefs.getDouble("score");
    setState(() {
      loading = false;
    });
  }
  @override
  void initState() {
    getPrefs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading==true)?Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('Assets/userProfile.png'),
                        fit: BoxFit.fill
                    )
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
                padding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Stack(
                  children: [
                    Visibility(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                      ),
                      visible: false,
                    ),
                    Positioned(
                      child: LinearPercentIndicator(
                        padding: EdgeInsets.only(
                            top: 22.5, left: 5, right: 10),
                        width: MediaQuery.of(context).size.width - 40,
                        percent: value,
                        animation: true,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: secondaryGreen,
                        backgroundColor: secondaryGreen.withAlpha(100),
                      ),
                    ),
                    Positioned(
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment(0.8, 0.0),
                                    // 10% of the width, so there are ten blinds.
                                    colors: [
                                      secondaryGreen,
                                      secondaryGreen
                                    ], // whitish to gray
                                  )),
                              child: Icon(
                                Icons.done,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text("WEAK",style: normal,),
                            ),
                          ],
                        )),
                    Positioned(
                        left: MediaQuery.of(context).size.width / 2 -
                            40,
                        child: Column(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: (value >= 0.5)
                                    ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 0.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: [
                                    secondaryGreen,
                                    secondaryGreen
                                  ], // whitish to gray
                                )
                                    : LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 0.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: [
                                    primaryBlue,
                                    primaryBlue
                                  ], // whitish to gray
                                ),
                              ),
                              child: Icon(
                                (value >= 0.5)
                                    ? Icons.done
                                    : Icons.star,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text("MEDIUM",style: normal,),
                            ),
                          ],
                        )),
                    Positioned(
                        right: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: (value == 1)
                                    ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 0.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: [
                                    secondaryGreen,
                                    secondaryGreen
                                  ], // whitish to gray
                                )
                                    : LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 0.0),
                                  // 10% of the width, so there are ten blinds.
                                  colors: [
                                    primaryBlue,
                                    primaryBlue
                                  ], // whitish to gray
                                ),
                              ),
                              child: Icon(
                                (value == 1)
                                    ? Icons.done
                                    : Icons.star,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text("STRONG",style: normal,),
                            ),
                          ],
                        ))
                  ],
                )
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey,
            ),
            Column(
              children: tiles.map((e){
                return MyTile(e);
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
  Widget MyTile(String text)
  {
    return Column(
      children: [
        ListTile(
          onTap: (){
            int index = tiles.indexOf(text);
            if(index==0)
              {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>UploadDocuments()));
              }
            if(index==1)
            {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>CovidCheck()));
            }
            else if(index==2)
              {
                Navigator.push(context,MaterialPageRoute(builder: (context)=>ChatMessages()));
              }
            else if(index==3)
            {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Reminders()));
            }
          },
          leading: Icon(icons[tiles.indexOf(text)],color: primaryBlue,),
          title: Text(text,style: normal,),
          trailing: Icon(Icons.arrow_forward),
        ),
        Container(
          height: 1,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
        )
      ],
    );
  }
}
