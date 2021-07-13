import 'package:chat_app/views/GroupChats/grouproom.dart';
import 'package:chat_app/views/chatroom.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatefulWidget {
  // const CategorySelector({ Key? key }) : super(key: key);

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {

  List<Widget> _screens = [
    ChatRoom(),
    GroupRoom(),
  ];
  int selectedIndex = 0;
  final List<String> categories =[
    'Messages', 'Groups',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: menuBar(context),
      body: Column(
        children: [
          Container(
            height: 60.0,
            color: Theme.of(context).primaryColor,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, int index){
                return GestureDetector(
                  onTap: () => setState((){
                    selectedIndex = index;
                  }),
                  child: Padding(
                    padding:EdgeInsets.symmetric(horizontal: 45,vertical:13),
                    child: Text(categories[index], style: TextStyle(
                      color: index == selectedIndex ?  Colors.white : Colors.white60,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),),
                  ),
                );
              }   
            ),
          ),
          Flexible(
            child: IndexedStack(
              index: selectedIndex,
              children: _screens,
            )
          ),
        ],
      ),
      
    );
  }
}