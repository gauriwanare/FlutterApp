import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Participants extends StatefulWidget {
  // const Participants({ Key? key }) : super(key: key);
  final String channelName;

  Participants(this.channelName);

  @override
  _ParticipantsState createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
  List participants;
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isLoading = true;

  @override
  void initState() {
    getParticipants();
    // participantsprint();
    super.initState();
  }

  getParticipants() async {
    DocumentReference docRef = FirebaseFirestore.instance
      .collection('videoCallRoom')
      .doc(widget.channelName);
    DocumentSnapshot doc = await docRef.get();  
    setState(() {
      participants = doc['userNames'];
      isLoading = false;
    });
  }
  
  Widget participantList(){
    return ListView.builder(
      itemCount: participants.length,
      itemBuilder: (context, int index){
        return ParticipantsTile(participants[index]);
      }
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Participants", 
          style: TextStyle(
            fontSize: 28.0,
          ),
        ),
      ),
      body: isLoading ? Container(
          child: Center(child: CircularProgressIndicator()),
        ) :
          participantList(),
    );
  }

}

class ParticipantsTile extends StatelessWidget {
  final String userName;
  ParticipantsTile(this.userName);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.black,
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(40),
                  ),
                child: Text("${userName.substring(0,1).toUpperCase()}",
                style: mediumTextStyle()),
              ),
              SizedBox(width: 8,),
              Text(userName, style: mediumTextStyle(),),
            ],
            ),
        ),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}