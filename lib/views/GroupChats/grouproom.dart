import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/GroupChats/GroupConvo.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class GroupRoom extends StatefulWidget {
  @override
  _GroupRoomState createState() => _GroupRoomState();
}

Stream groupRoomStream;
class _GroupRoomState extends State<GroupRoom> {
  DatabaseMethods databaseMethods = new DatabaseMethods();


  @override
  void initState() {

    databaseMethods.getGroupRooms(Constants.myUserId).then((val){
        setState(() {
          groupRoomStream = val;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ChatListContainer(Constants.myUserId),
      ),
    );
  }
}


class ChatListContainer extends StatefulWidget {
  // const ChatListContainer({ Key? key }) : super(key: key);
  final String currentUserId;

  ChatListContainer(this.currentUserId);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: groupRoomStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              int time = snapshot.data.docs[index]['time'];
              String channelName =  snapshot.data
                .docs[index]['name'].toString();      
              return GroupRoomsTile(
                channelName,
                time,
              );
            }
          ) : Container();
        },
    )
      
    );
  }
}






class GroupRoomsTile extends StatelessWidget {
  final String channelName;
  final int time;
  GroupRoomsTile(this.channelName, this.time);
  
  timeData(int time){
    return  DateTime
    .fromMicrosecondsSinceEpoch(time)
    .toString()
    .substring(11,16);
  }
  
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => GroupConvoScreen(channelName,false)
          ));
      },
      child: Column(
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
                  child: Text("${channelName.substring(0,1).toUpperCase()}",
                  style: mediumTextStyle()),
                ),
                SizedBox(width: 8,),
                Text(channelName, style: mediumTextStyle(),),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                  child: Text(timeData(time), style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),)),
              ],
              ),
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}