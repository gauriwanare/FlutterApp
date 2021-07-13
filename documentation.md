
# Design Documentation
# Summary
Prototype for Microsoft Engage 2021 challenge as individual contributor using Agile methodology.
# Objective 
To develop Teams Clone with mandatory feature of 1:1 video calling. The solution could be either a mobile based application or web based.
# Success criteria
Fully functional prototype with at least one mandatory functionality - a minimum of two participants should be able connect with each other using your product to have a video conversation. Using Agile Methodology, we should be able to divide the work in sprints. In “adapt” phase a surprise feature was disclosed that is chatting within a video call which could be continued when the call ends.

# Overview 
This is a mobile application developed using flutter and implemented various features using different flutter open source packages available
# Features 
* Authentication
Email login/ signup
1 . Fully Functional Chat Feature

> message sending time is visible

2 . Groups Feature

> Add to group

> Create New Group

> Leave Group

3 Search a User

4 Features in the video call

> Mute and Unmute

> Toggle the video

> Showing Participants in the Video Call

> Unlimited People Can join the Call
>  Sharing Screen 

> Raising Hand 

> Enter Tile View

> Start Recording the Meet

> Share a Youtube Video option(it can be directly streamed )

> Adding Meeting Password 

> One to one Private incall Messages 

> Audio mode only feature 

> Mute all participants

> Picture in Picture mode

> Blurring the Background or Changing it 
# Packages and APIs
  * For authenticating the user
> Used firebase authentication flutter package and implemented email- password sign in.
> Assigns each user a unique uid (first part of the email + domain name) which is used as key for storing the user’s details in the database.
  * For implementing the video calling feature
 >   used jitsi sdk in flutter for Sharing Screen , Raising Hand ,Enter Tile View ,Start Recording the Meet ,Share a Youtube Video option(it can be directly streamed ) , Adding Meeting Password , One to one Private incall Messages , Audio mode only feature 
  * For Database
> Used Firestore database for storing the data such as user’s information, chats shared by the users, groups.

# Working of the app and user walkthrough:
## Single chats
Users can register using any email , After registering user get into chat page which the main page , here user will see a search bar on the bottom right of the page. Clicking on it forwards user to search screen. Users can search for other registered using their userId’s (the first part of the email before ‘@’ + domain of the email -> for example john@gmail.com -> the user ID assigned to this user will be johngmail.) 
From here user can click on message button to text the other person. 

The message functionality works as follows:-

-	When a person clicks on the message button on search screen a new document is created under chatRoom collection of firebase. The name of the document is as “userId1_userId2” (userId1 is lexographically smaller than userId2 will be referred to as ChatId) this document contains field such as list of users present in chat, Time of the latest message, Also it consists of another section called chats where all chats are stored . The chat collection contains message documents with fields such as time of message , sent by , message details.

- All the documents names in which the user’s UserId is present in the users list in the chatroom collection are fetched from firebase and displayed on users chat room.

-	A new document is added to chatId each time the user sends a message.

The group feature works in a similar fashion. 

## Groups
Creating groups is an easy task. The user just has to switch to the group section click on the plus button on the bottom right create a group name. Search for users using userId’s similar to searching in 1-1 chat section. Click on the Top right button when done adding users . The button will only activate if u add atleast 1 user.
Users can also leave groups easily by just going inside the group and clicking on the leave option 

## Video Calls

Video calls are based of on Jitsi so inorder to avoid joining random calls , We created a room-id based on current time in milliseconds since Epoch concatenated with “chatapp” at the end. To make it easier for people to join rooms together we implemented copy room ID and also paste room ID. Also just long press on the chat message will automatically copy the text to the clipboard. 

So users can just copy the room ID from the clipboard(which is automatically generated) send it to other users then other users can come to the video call section just paste in the room ID by double tapping on the paste button. Hurray and then users can enjoy some facetime together with a load of features built in. 
Other’s Friends not registered on the app, Why worry we got you. Users can share the room link on multiple social media platforms so other friends can join them.





# APPENDIX

https://pub.dev/packages/jitsi_meet

https://pub.dev/packages/firebase_auth

https://pub.dev/packages/cloud_firestore

https://pub.dev/packages/shared_preferences

https://pub.dev/packages/firebase_core

https://pub.dev/packages/permission_handler

https://pub.dev/packages/emoji_picker

https://pub.dev/packages/clipboard


