import 'package:chat_app/helper/authenticate.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/views/GroupVideoCall/HomePage.dart';
import 'package:flutter/material.dart';

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset("assets/images/logo.png",height: 50,),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

Widget customAppBar(context){
  AuthMethods authMethods = new AuthMethods();
  return AppBar(
        title: Center(
          child: Text("Chats" , style: TextStyle(
            fontSize: 28.0, 
            fontWeight: FontWeight.bold
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement (context, MaterialPageRoute(
                builder: (context) => MyHomePage() 
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(Icons.videocam),
            ),
          ),
          GestureDetector(
            onTap: (){
              authMethods.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authenticate(),
                ),);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app)),
          ),
        ],
      );
}

 menuBar(context){
    return ClipRRect(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(35)),

        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff145C9E),
                ),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("UserName: ", style: customFontStyle(15, 1)),
                      Text(Constants.myName,style: customFontStyle(22, 0)),
                      SizedBox(height: 5,),
                      Text("UserId: ", style: customFontStyle(15, 1)),
                      Text(Constants.myUserId,style: customFontStyle(22, 0)),    
                      SizedBox(height: 5,),
                      Text(Constants.myEmail,style: customFontStyle(19, 0)),
                    ],
                  ),
                )
              ),

             new ListTile(
                leading: Icon(Icons.videocam, ),
                title: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),  
                  child: Text("Group Video Call", style: TextStyle(fontSize: 25),
                )),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyHomePage())
                    );
                },
              )
            ],
          ),
        ),
      );
  }



InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white54),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}

TextStyle mediumTextStyle() {
  return TextStyle(color: Colors.white, fontSize: 16);
}

TextStyle customFontStyle(double size,int underline){
  return TextStyle(
      color: Colors.white, 
      fontSize: size,
      decoration : ((underline == 1) ? 
        TextDecoration.underline 
        : TextDecoration.none),
    );
}