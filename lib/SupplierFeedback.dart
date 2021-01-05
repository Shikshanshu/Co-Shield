import 'package:blockchain/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SupplierFeedback extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SupplierFeedback();
  }
}
List data = [
  {
    'title': "Delivery",
    'description': "Rate your experience based on vaccine delivery time and route optimizations"
  },
  {
    'title': "Customer Support",
    'description': "Were your queries related to vaccine answered by the helpline? Rate them here!"
  },
  {
    'title': "Service",
    'description': "Was the vaccine delivered to you in right state? Provide feedback on the services of the organization"
  },
  {
    'title': "Vaccine Security",
    'description': "Check whether cold chain was breached during vaccine delivery and report any issues here!"
  },
  {
    'title': "Record Update",
    'description': "Rate your experience based on how much time the organization took to update data with the government"
  },
];
List<int> selected = [-1,-1,-1,-1,-1];
class _SupplierFeedback extends State<SupplierFeedback>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Text("Leave a Review",style: heading,),
            SizedBox(
              height: 30,
            ),
            Column(
              children: data.map((e){
                return Column(
                  children: [
                    Text(e['title'],style: subheading,),
                    Padding(padding: EdgeInsets.all(20),
                    child: Text(e['description'],style: normal,textAlign: TextAlign.center,),),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(),
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.sentiment_very_dissatisfied_rounded,
                            color: (selected[data.indexOf(e)]==0)?Colors.amber:Colors.black,
                            size: 40,
                          ),
                          onTap: (){
                            setState(() {
                              selected[data.indexOf(e)] = 0;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.sentiment_dissatisfied_rounded,
                            color: (selected[data.indexOf(e)]==1)?Colors.amber:Colors.black,
                            size: 40,
                          ),
                          onTap: (){
                            setState(() {
                              selected[data.indexOf(e)] = 1;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.sentiment_neutral_rounded,
                            color: (selected[data.indexOf(e)]==2)?Colors.amber:Colors.black,
                            size: 40,
                          ),
                          onTap: (){
                            setState(() {
                              selected[data.indexOf(e)] = 2;
                            });
                          },
                        ),
                        GestureDetector(
                          child:  Icon(
                            Icons.sentiment_satisfied_alt_rounded,
                            color: (selected[data.indexOf(e)]==3)?Colors.amber:Colors.black,
                            size: 40,
                          ),
                          onTap: (){
                            setState(() {
                              selected[data.indexOf(e)] = 3;
                            });
                          },
                        ),
                        GestureDetector(
                          child: Icon(
                            Icons.sentiment_very_satisfied_rounded,
                            color: (selected[data.indexOf(e)]==4)?Colors.amber:Colors.black,
                            size: 40,
                          ),
                          onTap: (){
                            setState(() {
                              selected[data.indexOf(e)] = 4;
                            });
                          },
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }).toList(),
            ),
            FlatButton(
              color: Colors.amber,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: (){
                int flag=0;
                for(int i=0;i<5;i++)
                {
                  if(selected[i]==-1)
                  {
                    flag=1;
                    break;
                  }
                }
                if(flag==1)
                {
                  Fluttertoast.showToast(msg: "Please Provide FeedBack for all fields");
                }
                else
                {
                  Fluttertoast.showToast(msg: "Feedback submitted succcessfully");
                  Navigator.pop(context);
                }

              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Submit",style: heading1),
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