import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/GroupVideoCall/CallPage.dart';
import 'package:chat_app/widgets/categoryselector.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  bool _validateError = false;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool ifGroupExist;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Video Calling'),
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushReplacement (context, MaterialPageRoute(
                builder: (context) => CategorySelector() 
              ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.chat_sharp),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Container(
                //   child: Image.asset('assets/agora-logo.png'),
                //   height: MediaQuery.of(context).size.height * 0.1,
                // ),
                Padding(padding: EdgeInsets.only(top: 20)),
                Text(
                  'Video Call',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    controller: myController,
                    style: mediumTextStyle(),
                    decoration: InputDecoration(
                      labelText: 'Channel Name',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'test',
                      hintStyle: TextStyle(color: Colors.white38),
                      errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: MaterialButton(
                    onPressed: onJoin,
                    height: 40,
                    color: Colors.blueAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Join',
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    setState(() {
      myController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if(_validateError == false){
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);

    String groupName = myController.text.toLowerCase();
    
    databaseMethods.addUsersToVideoCallList(
      groupName, Constants.myUserId
      );
    
    ifGroupExist = await databaseMethods.groupExists(groupName);


    
    // updating the users 
    // if userId already exists doesn't affect the group
    if(ifGroupExist == true){
      databaseMethods.addUserToGroup(groupName, Constants.myUserId);
    }
    else{
    // if Group doesn't exists creating the group 
      List users = [Constants.myUserId];
      Map<String, dynamic> groupRoomMap = {
        'name' : groupName,
        'users' : users,
        'time' : DateTime.now().microsecondsSinceEpoch,
      };
      databaseMethods.createGroupChatRoom(groupName, groupRoomMap);
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(channelName : groupName),
        ));
    }
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
