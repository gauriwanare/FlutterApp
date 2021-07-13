
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/utils/universal_variables.dart';
import 'package:chat_app/widgets/categoryselector.dart';
import 'package:flutter/material.dart';

// channelName is same as groupName 

class GroupConvoScreen extends StatefulWidget {
  // const GroupConvoScreen({ Key? key }) : super(key: key);

  final String channelName;
  final bool inVideo;
  
  GroupConvoScreen(this.channelName, this.inVideo);

  @override
  _GroupConvoScreenState createState() => _GroupConvoScreenState();
}

class _GroupConvoScreenState extends State<GroupConvoScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  Stream chatMessageStream;
  TextEditingController messageController = new TextEditingController();
  FocusNode textFieldFocus = new FocusNode();

  @override
  void initState() {
    databaseMethods.getGroupConversationMessage(widget.channelName).then((val){
      setState(() {
        chatMessageStream = val;
      });
    } );
    super.initState();
  }

   Widget chatMessageList(){
    return Container(
      child: StreamBuilder(
        stream: chatMessageStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
            reverse: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context,index){
              return MessageTile(
                snapshot.data.docs[index]["message"],
                snapshot.data.docs[index]["sendBy"],
                Constants.myName == snapshot.data.docs[index]["sendBy"],
                snapshot.data.docs[index]["time"],
                );
            }
          ) :Container() ;
        }

      ),
    );
  }

  
  sendMessage(){
    if(messageController.text.isNotEmpty){ 
       Map<String, dynamic> messageMap = {
      "message" : messageController.text,
      "sendBy" : Constants.myName,
      "time" : DateTime.now().microsecondsSinceEpoch,
    }; 
    databaseMethods.addConversationMessageInGroup(widget.channelName, messageMap);
    messageController.text = "";
    }
  }


  void onSelected(BuildContext context, int item){
    switch (item) {
      case 0 :{
        if(widget.inVideo == true){
          databaseMethods.leaveGroup(widget.channelName);
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => CategorySelector()
          ));
        }else{
          Navigator.pop(context);
          databaseMethods.leaveGroup(widget.channelName);
        }
        
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child : Text(widget.channelName, style: TextStyle(
          fontSize: 28.0,
          fontWeight : FontWeight.bold,
        ),),),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => onSelected(context,item),
            itemBuilder: (context) => [  
              PopupMenuItem<int>(
                
                value: 0,
                child: Text("Leave group")
                ),
            ]
            ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: chatMessageList() ,
              ),
              chatControls(),
              // showEmojiPicker ? Container(child: emojiContainer(),) 
              // : Container(),
            ],
          ),
        ),
      ),
    );
  }


    Widget chatControls(){
   return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
  
        padding: EdgeInsets.all(10),
        // padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        // color: Color(0x54FFFFFF),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                  controller: messageController,
                  focusNode: textFieldFocus,
                  // onTap: () => hideEmojiContainer() ,
                  textCapitalization : TextCapitalization.sentences, 
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Type a message",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                      borderSide: BorderSide.none,
                      ),
                    contentPadding: 
                      EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                      filled: true,
                      fillColor: UniversalVariables.separatorColor,
                      // suffixIcon: IconButton(
                      //   splashColor: Colors.white,
                      //   highlightColor: Colors.white,
                      //   // onPressed: () {
                      //   //   if(!showEmojiPicker){
                      //   //     hideKeyboard();
                      //   //   }
                      //   //   else {
                      //   //     showKeyboard();
                      //   //   }
                      //   //   toggleEmojiContainer();
                      //   // },
                      //   icon: Icon(Icons.face , color: Colors.white,),
                      // )
                ),
              ),
            ),
            Container(
                  margin: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                      color: UniversalVariables.blueColor,
                      shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 22,
                      color: Colors.white,
                    ),
                    onPressed: () => sendMessage(),
                  )
              )
          ],
        ),
      ),
    );

  }
}


// Message tile to display message
class MessageTile extends StatelessWidget {
  final String message;
  final String sentBy;
  final bool isSendByMe;
  final int sentTime;
  MessageTile(this.message, this.sentBy , this.isSendByMe, this.sentTime);

  timeData(int time){
    return  DateTime
    .fromMicrosecondsSinceEpoch(sentTime)
    .toString()
    .substring(11,16);
  }



  @override
  Widget build(BuildContext context) {

    
    return Container(
      child: Container(
        padding: EdgeInsets.only(
          left: isSendByMe ? 0:  10,
          right: isSendByMe ? 10 : 0
        ),

        margin: EdgeInsets.symmetric(vertical: 8),
        width: MediaQuery.of(context).size.width,
        alignment: isSendByMe ? 
          Alignment.centerRight 
          : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.65,
          ) ,
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                 colors: isSendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
                ] : [
                const Color(0x1AFFFFFF),
                const Color(0x1AFFFFFF)
              ],
              ),
              borderRadius: isSendByMe ?
                BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23)
                ): BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)
                )
            ),
            child: Column(
              crossAxisAlignment :CrossAxisAlignment.end,
              children: [
                  Text(sentBy, style: TextStyle(
                      color: Colors.white, fontSize: 10 
                      ),
                    ),
                  Text(message,style: TextStyle(
                      color: Colors.white, fontSize: 16
                     ),
                    ),
                SizedBox(height: 6.0,),
                  Text(timeData(sentTime),style: TextStyle(
                      color: Colors.white, fontSize: 11
                    ),
                  ),
              ],
            ),
        ),
      ),
    );
  }
}


