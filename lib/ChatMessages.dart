import 'package:blockchain/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget{
  String text = "Doctor's Community";
  @override
  State<StatefulWidget> createState() {
    return _ChatMessages(text);
  }
}
List<QueryDocumentSnapshot> data = new List();
bool loading = true;
class _ChatMessages extends State<ChatMessages>{
  String text;
  _ChatMessages(this.text);
  TextEditingController controller = new TextEditingController();
  void getDataFromFirebase(){
    FirebaseFirestore.instance.collection("chat").doc(text).collection("messages").orderBy('time').get().then((value){
      data = value.docs;
      setState(() {
        loading = false;
      });
    });
  }
  @override
  void initState() {
    loading = true;
    data = new List();
    getDataFromFirebase();
    controller = new TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return (loading == true)?Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryBlue,
        title: Text(text,style: heading1,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "Assets/chatBackground.png"
                    ),
                    fit: BoxFit.fill
                )
            ),
          ),
          Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),),
          ),
        ],
      )
    ):Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryBlue,
        title: Text(text,style: heading1,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "Assets/chatBackground.png"
                ),
                fit: BoxFit.fill
              )
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      children: data.map((e){
                        return buildChatItem(e);
                      }).toList()
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  maxHeight: 200,
                ),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: TextField(
                          style: normal1,
                          minLines: null,
                          maxLines: null,
                          controller: controller,
                          decoration: InputDecoration(
                            fillColor: primaryBlue,
                            hintStyle: normal1,
                            hintText: "Type your message",
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.grey.shade400)
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.grey.shade400)
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: primaryBlue
                        ),
                      )
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: secondaryGreen,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.send,size: 30,),
                          color: Colors.white,
                          onPressed: (){
                            FirebaseFirestore.instance.collection("chat").doc(text).collection("messages").add({
                              'id': FirebaseAuth.instance.currentUser.uid,
                              'message': controller.text,
                              'time': DateTime.now().millisecondsSinceEpoch.toString(),
                            });
                            setState(() {
                              controller.text = "";
                              loading = true;
                            });
                            getDataFromFirebase();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      )
    );
  }

  Widget buildChatItem(QueryDocumentSnapshot document)
  {
    if(document.get('id')==FirebaseAuth.instance.currentUser.uid)
      return Row(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width*0.6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
              color: secondaryGreen,
            ),
            child: Text(document.get('message'),style: chatNormal1,),
          )
        ],
      );
    else
      return Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width*0.6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
              color: primaryBlue,
            ),
            child: Text(document.get('message'),style: chatNormal1,),
          ),
          Expanded(
            child: SizedBox(),
          )
        ],
      );
  }
}