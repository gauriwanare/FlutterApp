import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/helper/recieverDetails.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/utils/universal_variables.dart';
import 'package:chat_app/views/conversation_screen.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController = new TextEditingController();

  QuerySnapshot searchSnapshot;

  // Get QuerySnapshot for the search 
  initiateSearch(){
    databaseMethods
        .getUserByUserId(searchTextEditingController.text.trim())
        .then((val){
          setState(() {
            searchSnapshot = val;
          });
        }
    );
  }

 


  Widget searchList(){
    return searchSnapshot != null ?  ListView.builder(
      itemCount: searchSnapshot.docs.length,
      shrinkWrap: true,
      itemBuilder: (context, index){
        return searchTile(
          userName: searchSnapshot.docs[index]["name"],
          userId: searchSnapshot.docs[index]["userId"],
          userEmail: searchSnapshot.docs[index]["email"],
        );
      },
    ) :Container();
  }

 createChatroomAndStartConversation(String userId,String userName){

    if(userId != Constants.myUserId){
      String chatRoomId = getChatRoomId(userId, Constants.myUserId);

      List<String> users = [userId, Constants.myUserId];
      List<String> userNames = [ userName ,Constants.myName ];
      Map<String, dynamic> chatRoomMap = {
        "users" : users,
        "userNames" : userNames,
        "chatroomId" : chatRoomId ,
        "time" : DateTime.now().microsecondsSinceEpoch,
      };
      RecieverDetails.recieverUserName = userName;
      RecieverDetails.recieverUserId = userId;
      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => ConversationScreen(chatRoomId,RecieverDetails.recieverUserName),
      ));
      }else{
        print("You cant text urself");
      }

  }

  Widget searchTile({String userName,String userId, String userEmail}){
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical : 16),
      child: Row(
        children:[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(userName,style: mediumTextStyle(),),
              Text(userEmail, style: mediumTextStyle(),),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatroomAndStartConversation(
                userId,
                userName
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
                ),
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
              child: Text("Message", style: mediumTextStyle(),)),
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }




  @override
  void initState() {
    initiateSearch();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: TextStyle(
          fontSize: 28.0, fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            searchControl(),
            searchList(),
          ],),
      ),

    );
  }
    Widget searchControl(){
       return Container(
        child: Container(
        padding: EdgeInsets.all(10),
        // padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
        // color: Color(0x54FFFFFF),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                  controller: searchTextEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search UserId....",
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
                      Icons.search,
                      size: 22,
                      color: Colors.white,
                    ),
                    onPressed: () => initiateSearch(),
                  )
              )
          ],
        ),
      ),
    );
    }
}







 getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
