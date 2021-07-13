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
> Used firebase authentication flutter package and implemented email- password sign in and google sign in.
> Assigns each user a unique uid which is used as key for storing the user’s details in the database.
  * For implementing the video calling feature
 >   used jitsi sdk in flutter for Sharing Screen , Raising Hand ,Enter Tile View ,Start Recording the Meet ,Share a Youtube Video option(it can be directly streamed ) , Adding Meeting Password , One to one Private incall Messages , Audio mode only feature 
  * For Database
> Used Firestore database for storing the data such as user’s information, contacts, chats shared by the users.




# APPENDIX

https://pub.dev/packages/jitsi_meet

https://pub.dev/packages/firebase_auth

https://pub.dev/packages/cloud_firestore

https://pub.dev/packages/shared_preferences

https://pub.dev/packages/firebase_core

https://pub.dev/packages/permission_handler

https://pub.dev/packages/emoji_picker

https://pub.dev/packages/clipboard



# Meetegy
## Microsoft Engage 2021

A fully functional Flutter Application with Chatting(group/single), Video Calling .

## Getting Started
- `git clone https://github.com/gauriwanare/FlutterApp.git`
- `cd FlutterApp`
- `flutter packages get`
- `flutter run`

# Screenshots
## Sign up and Sign in screens 
<img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/signup.jpeg"/> <img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/Signin.jpeg"/> 

## Chat Screen And Chat
<img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/SingleChat.jpeg"/> <img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/SingleChatConvo.jpeg"/> <img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/GroupChats.jpeg"/> <img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/GroupChatConvo.jpeg"/> <img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/AddingToGroup.jpeg"/> <img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/LeaveGroup.jpeg"/> 

## Video Call 
<img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/videoCallRoomPage.jpeg"/> <img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/InvideoCall.jpeg"/> <img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/videoCallFeatures.jpeg"/> <img width="180" height="350" src="https://github.com/gauriwanare/FlutterApp/blob/main/SS/SharingVideoCallToApps.jpeg"/> 
